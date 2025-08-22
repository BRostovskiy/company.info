package clients

import (
	"errors"
)

const (
	ErrCodeInternalError = 100
	ErrCodeBadRequest    = 101
	ErrCodeConflict      = 102
	ErrCodeNotFound      = 103
	ErrCodeAlreadyExists = 104

	ErrCodeValidateJWTNotInitialized = 200
	ErrCodeValidateJWTParse          = 201
	ErrCodeValidateJWTNotValid       = 202
	ErrCodeValidateJWTInvalidClaims  = 203
)

var (
	//ErrInternal                   = &Error{Code: ErrCodeInternalError, Message: "service internal error"}
	ErrUserAlreadyExists = &Error{Code: ErrCodeAlreadyExists, Message: "user already exists"}
	//ErrUserNotFound               = &Error{Code: ErrCodeNotFound, Message: "user not found"}
	//ErrDuplicateKeyError          = &Error{Code: ErrCodeConflict, Message: "duplicate key error"}
	ErrValidateJWTNotInitialized = &Error{Code: ErrCodeValidateJWTNotInitialized, Message: "JWKS was not initialized"}
	ErrValidateJWTNotValid       = &Error{Code: ErrCodeValidateJWTNotValid, Message: "JWT token parsed but not valid"}
	ErrValidateJWTInvalidClaims  = &Error{Code: ErrCodeValidateJWTInvalidClaims, Message: "invalid claims"}
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
