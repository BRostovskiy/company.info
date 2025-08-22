package repository

import (
	"fmt"
)

var (
	ErrorDuplicateKey   = fmt.Errorf("duplicate key value violates unique constraint")
	ErrorRecordNotFound = fmt.Errorf("not found")
)
