package repository

import (
	"fmt"
)

var (
	ErrorDuplicateKey = fmt.Errorf("duplicate key value violates unique constraint")
	ErrorKeyNotFound  = fmt.Errorf("not found")
)
