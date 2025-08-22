package service

import (
	"errors"
)

const (
	ErrCodeInternalError = 100
	ErrCodeBadRequest    = 101
	ErrCodeConflict      = 102
	ErrCodeNotFound      = 103
	ErrCodeAlreadyExists = 104
)

var (
	//ErrInternal                   = &Error{Code: ErrCodeInternalError, Message: "service internal error"}
	ErrAlreadyExists     = &Error{Code: ErrCodeAlreadyExists, Message: "record already exists"}
	ErrNotFound          = &Error{Code: ErrCodeNotFound, Message: "record not found"}
	ErrDuplicateKeyError = &Error{Code: ErrCodeConflict, Message: "duplicate key error"}
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
