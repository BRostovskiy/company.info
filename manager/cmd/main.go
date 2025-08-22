package main

import (
	"context"
	"errors"
	"flag"
	"fmt"
	"net/http"
	"os"
	"os/signal"
	"strings"
	"syscall"
	"time"

	nested "github.com/antonfisher/nested-logrus-formatter"
	"github.com/go-chi/chi/v5/middleware"
	_ "github.com/jackc/pgx/v4/stdlib"
	"github.com/jmoiron/sqlx"
	"github.com/kouhin/envflag"
	"github.com/sirupsen/logrus"

	usersClient "github.com/BorisRostovskiy/company.info/manager/clients/users"
	httpHandler "github.com/BorisRostovskiy/company.info/manager/internal/handlers/http"
	"github.com/BorisRostovskiy/company.info/manager/internal/repository"
	"github.com/BorisRostovskiy/company.info/manager/internal/service"
	projLog "github.com/BorisRostovskiy/company.info/manager/log"
)

var version = "dev"

type config struct {
	LogLevel string
	Handler  httpHandler.Config
	Repo     repository.Config
	Users    usersClient.Config
}

func (c *config) mustLoad() {
	flag.StringVar(&c.LogLevel, "log-level", "debug",
		"Log level. Available options: debug, info, warn, error")

	c.Handler = httpHandler.Config{}
	// HTTP
	flag.StringVar(&c.Handler.ServiceAddr, "http-service-addr", "localhost", "service host")
	flag.DurationVar(&c.Handler.DefaultTimeout, "http-default-timeout", 2*time.Second, "default request timeout")

	// Users client
	c.Users = usersClient.Config{}
	flag.StringVar(&c.Users.URL, "users-url", "", "users base url")
	flag.DurationVar(&c.Users.RequestTimeout, "api-request-timeout", 1*time.Second, "api request timeout")

	c.Repo = repository.Config{}
	// Repository
	flag.StringVar(&c.Repo.User, "db-user", "", "database user")
	flag.StringVar(&c.Repo.Pwd, "db-password", "", "database password")
	flag.StringVar(&c.Repo.Server, "db-host", "", "database host")
	flag.StringVar(&c.Repo.DBName, "db-name", "", "database name")

	if err := envflag.Parse(); err != nil {
		logrus.Fatal(err)
	}
}

func setupLogger(lvl string) *logrus.Logger {
	logger := logrus.New()
	logger.SetFormatter(&nested.Formatter{
		HideKeys:        true,
		FieldsOrder:     []string{"proto", "method", "component", "uri", "status_code", "bytes"},
		NoFieldsColors:  true,
		TimestampFormat: "2006-01-02 15:04:05",
	})
	switch strings.ToLower(lvl) {
	case "debug":
		logger.SetLevel(logrus.DebugLevel)
	case "info":
		logger.SetLevel(logrus.InfoLevel)
	case "error":
		logger.SetLevel(logrus.ErrorLevel)
	default:
		logger.SetLevel(logrus.DebugLevel)
	}
	return logger
}

func mustSetupRepo(cfg repository.Config, log *logrus.Logger) *repository.Repo {
	dsn := fmt.Sprintf("postgres://%s:%s@%s/%s?sslmode=disable", cfg.User,
		cfg.Pwd,
		cfg.Server,
		cfg.DBName)
	db, err := sqlx.Connect("pgx", dsn)
	if err != nil {
		log.Fatalf("failed to connect to pg repository: %v", err)
	}
	return repository.New(db, log)
}

func setupUsersClient(cfg usersClient.Config) *usersClient.Client {
	return usersClient.New(cfg)
}

func setupAPI(repo *repository.Repo, client *usersClient.Client) *service.APICaller {
	return service.New(repo, client)
}

func main() {
	cfg := &config{}
	cfg.mustLoad()

	logger := setupLogger(cfg.LogLevel)
	repo := mustSetupRepo(cfg.Repo, logger)
	client := setupUsersClient(cfg.Users)
	api := setupAPI(repo, client)
	middleware.DefaultLogger = middleware.RequestLogger(
		&projLog.LogFormatter{
			Logger: logger,
		},
	)
	serverStopped := make(chan struct{})
	srv := &http.Server{
		Addr:         cfg.Handler.ServiceAddr,
		Handler:      httpHandler.New(logger, api, cfg.Handler),
		ReadTimeout:  cfg.Handler.DefaultTimeout,
		WriteTimeout: cfg.Handler.DefaultTimeout,
	}
	go func() {
		if err := srv.ListenAndServe(); err != nil {
			if !errors.Is(err, http.ErrServerClosed) {
				logger.Errorf("failed to start HTTP server: %v", err)
			}
		}
		close(serverStopped)
	}()

	logger.Infof("started server version=%s addr %s", version, cfg.Handler.ServiceAddr)

	term := make(chan os.Signal, 1)
	signal.Notify(term, syscall.SIGTERM, syscall.SIGINT)

	select {
	case sig := <-term:
		logger.Infof("terminating by signal %d", sig)

		ctx, cancel := context.WithTimeout(context.Background(), 30*time.Second)
		if err := srv.Shutdown(ctx); err != nil {
			logger.Fatalf("failed to stop HTTP server %v", err)
		} else {
			<-serverStopped
		}
		cancel()
	case <-serverStopped:
		logger.Fatal("server terminated unexpectedly")
	}

	logger.Info("stopped gracefully")
	os.Exit(0)
}
