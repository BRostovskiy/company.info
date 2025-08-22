package http

import (
	"context"
	"encoding/json"
	"net/http"
	"strconv"
	"strings"

	"github.com/BorisRostovskiy/company.info/manager/internal/service"
	"github.com/BorisRostovskiy/company.info/manager/log"
	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	"github.com/sirupsen/logrus"
)

const (
	HeaderContentType   = "Content-Type"
	HeaderContentLength = "Content-Length"
	UserCtxKey          = "user_context_key"
	TokenCtxKey         = "token_context_key"
)

type response interface {
	WriteTo(w http.ResponseWriter) error
}

type handler struct {
	log   *logrus.Logger
	api   ManagerService
	users UserService
	cfg   Config
}

type ManagerService interface {
	CreateRecord(ctx context.Context, accountID, name, value, token string) (string, error)
	GetRecords(ctx context.Context, accountID string) ([]service.Record, error)
	GetRecordDecrypted(ctx context.Context, accountID, recordID, token string) (*service.Record, error)
	UpdateRecord(ctx context.Context, accountID, recordID string, newValue, token string) error
	DeleteRecord(ctx context.Context, recordID string) error
	VerifyJWTToken(ctx context.Context, token string) (string, error)
}

type UserService interface {
	ValidateToken(ctx context.Context, token string) error
}

func New(log *logrus.Logger, api ManagerService, cfg Config) http.Handler {
	return router(&handler{
		log: log,
		api: api,
		cfg: cfg},
		log)
}

func (h handler) handle(hf func(r *http.Request) response) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		h.respond(w, hf(r))
	}
}

func (h handler) respond(w http.ResponseWriter, r response) {
	w.Header().Set(HeaderContentType, "application/json; charset=utf-8")
	if err := r.WriteTo(w); err != nil {
		h.log.Errorf("failed to write response: %s", err)
	}
}

func router(h *handler, l *logrus.Logger) *chi.Mux {
	r := chi.NewRouter()

	r.Use(log.LoggerWithLevel("router", l, l.Level))
	r.Use(middleware.Logger)
	r.Use(middleware.Recoverer)

	r.Route("/service/v1", func(r chi.Router) {
		r.Route("/records", func(r chi.Router) {
			r.Use(h.authMiddleware)
			r.Post("/", h.handle(h.createRecord))
			r.Get("/", h.handle(h.getRecords))
			r.Get("/{id}", h.handle(h.getRecord))
			r.Put("/{id}", h.handle(h.updateRecord))
			r.Delete("/{id}", h.handle(h.deleteRecord))
		})
	})

	return r
}

func (h handler) authMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		token := strings.TrimPrefix(r.Header.Get("Authorization"), "Bearer ")
		if token == "" {
			http.Error(w, "missing token", http.StatusUnauthorized)
			return
		}
		sub, err := h.api.VerifyJWTToken(r.Context(), token)
		if err != nil {
			http.Error(w, "failed to verify token", http.StatusUnauthorized)
			return
		}

		ctx := context.WithValue(r.Context(), UserCtxKey, sub)
		ctx = context.WithValue(ctx, TokenCtxKey, token)
		next.ServeHTTP(w, r.WithContext(ctx))
	})
}
func responseObject(w http.ResponseWriter, status int, obj interface{}) error {
	data, err := json.Marshal(obj)
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		return err
	}
	w.Header().Set(HeaderContentLength, strconv.Itoa(len(data)))
	w.WriteHeader(status)
	_, err = w.Write(data)
	return err
}
