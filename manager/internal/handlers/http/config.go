package http

import "time"

type Config struct {
	ServiceAddr    string        `yaml:"addr"`
	DefaultTimeout time.Duration `yaml:"default_timeout"`
}
