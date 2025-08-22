package repository

type Config struct {
	User   string `yaml:"user"`
	Pwd    string `yaml:"pwd"`
	Server string `yaml:"server"`
	DBName string `yaml:"db_name"`
}
