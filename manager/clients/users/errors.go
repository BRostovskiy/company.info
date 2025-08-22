package users

import (
	"errors"
)

const (
	ErrCodeInternalError = 100
	ErrCodeBadRequest    = 101
)

func NewError(code int, msg string) *Error {
	return &Error{Code: code, Message: msg}
}

type Error struct {
	Code    int    `json:"code"`
	Message string `json:"message"`
}

func (res *Error) Error() string {
	return res.Message
}

func ToError(err error) *Error {
	var e *Error
	if errors.As(err, &e) {
		return e
	}
	return nil
}
