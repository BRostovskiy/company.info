package service

import (
	"errors"
)

const (
	ErrCodeInternalError = 100
	ErrCodeBadRequest    = 101
	ErrCodeConflict      = 102
	ErrCodeAlreadyExists = 103

	ErrCodeValidateJWTNotInitialized = 200
	ErrCodeValidateJWTNotValid       = 201
	ErrCodeValidateJWTInvalidClaims  = 202
)

var (
	ErrUserAlreadyExists         = &Error{Code: ErrCodeAlreadyExists, Message: "user already exists"}
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
