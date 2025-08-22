package http

import (
	"errors"
	"net/http"

	"github.com/BorisRostovskiy/company.info/users/internal/service"
	"github.com/BorisRostovskiy/company.info/users/log"
)

var (
	apiErrorCodeStatus = map[int]int{
		service.ErrCodeBadRequest:    http.StatusBadRequest,
		service.ErrCodeInternalError: http.StatusInternalServerError,
		service.ErrCodeAlreadyExists: http.StatusConflict,
		service.ErrCodeConflict:      http.StatusConflict,
	}
	ErrInternal = &Error{
		Status:  http.StatusInternalServerError,
		Code:    service.ErrCodeInternalError,
		Message: "internal handlers error",
	}
)

type Error struct {
	Status  int    `json:"-"`
	Code    int    `json:"code"`
	Message string `json:"message"`
}

func (e *Error) Error() string {
	return e.Message
}

func (e *Error) WriteTo(w http.ResponseWriter) error {
	if e.Status <= 0 {
		e.Code = service.ErrCodeInternalError
		e.Status = http.StatusInternalServerError
	}
	return responseObject(w, e.Status, e)
}

func ToError(err error) *Error {
	var e *Error
	if errors.As(err, &e) {
		return e
	}
	return nil
}

// make response from error
func errResponse(status, code int, err error) response {
	if rErr := ToError(err); rErr != nil {
		return rErr
	}
	return &Error{Status: status, Code: code, Message: err.Error()}
}

// parse errors from parsing requests
func errRequest(r *http.Request, err error) response {
	log.WithError(r, err)
	return errResponse(http.StatusBadRequest, service.ErrCodeBadRequest, err)
}

// parse errors from service requests
func errApi(r *http.Request, format string, args ...interface{}) response {
	err := log.WithErrorf(r, format, args...)
	log.WithError(r, err)
	if e := service.ToError(errors.Unwrap(err)); e != nil {
		if status, ok := apiErrorCodeStatus[e.Code]; ok {
			return errResponse(status, e.Code, e)
		}
	}
	return ErrInternal
}
