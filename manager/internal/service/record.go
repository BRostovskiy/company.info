package service

import "time"

type Record struct {
	ID      string
	Name    string
	Value   string
	Created time.Time
}
