package http

import (
	"context"
	"encoding/json"
	"net/http"
	"strconv"
	"strings"

	"github.com/BorisRostovskiy/company.info/users/internal/service"
	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	"github.com/golang-jwt/jwt/v4"
	"github.com/sirupsen/logrus"

	"github.com/BorisRostovskiy/company.info/users/log"
)

const (
	HeaderContentType   = "Content-Type"
	HeaderContentLength = "Content-Length"
	UserCtxKey          = "user_context_key"
)

type APICallerService interface {
	CreateKCUser(ctx context.Context, userName, email, firstName, lastName, password string) error
	GetKCUserByEmail(ctx context.Context, email string) (*service.GetUserResponse, error)
	LoginToKC(ctx context.Context, userName, userPWD string) (*service.LoginResponse, error)
	LogoutFromKC(ctx context.Context, token string) error
	VerifyKCToken(token string) (jwt.MapClaims, error)
	AddKey(ctx context.Context, acc, pubKey, privateKey string) error
	GetKeyByID(ctx context.Context, ID string) (string, string, error)
}

func New(api APICallerService, log *logrus.Logger, cfg *Config) http.Handler {
	h := &handler{
		cfg: cfg,
		log: log,
		api: api,
	}
	return router(h, log)
}

type handler struct {
	log *logrus.Logger
	api APICallerService
	cfg *Config
}

type response interface {
	WriteTo(w http.ResponseWriter) error
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

func router(h *handler, l *logrus.Logger) *chi.Mux {
	r := chi.NewRouter()

	r.Use(log.LoggerWithLevel("router", l, l.Level))
	r.Use(middleware.Logger)
	r.Use(middleware.Recoverer)

	r.Route("/service/v1", func(r chi.Router) {
		r.Route("/users", func(r chi.Router) {
			r.Post("/", h.handle(h.createUser))
			r.Post("/login", h.handle(h.login))
			r.Post("/logout", h.handle(h.logout))
			r.Get("/keys", h.authMiddleware(h.handle(h.getUserKeys)))
		})
		r.Route("/token", func(r chi.Router) {
			r.Get("/verify", h.handle(h.verifyToken))
		})
	})

	return r
}

func (h handler) authMiddleware(next http.Handler) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		token := strings.TrimPrefix(r.Header.Get("Authorization"), "Bearer ")
		if token == "" {
			http.Error(w, "missing token", http.StatusUnauthorized)
			return
		}
		claims, err := h.api.VerifyKCToken(token)
		if err != nil {
			http.Error(w, "failed to load verify token", http.StatusUnauthorized)
			return
		}
		if err = claims.Valid(); err != nil {
			http.Error(w, "claims not valid", http.StatusUnauthorized)
		}

		ctx := context.WithValue(r.Context(), UserCtxKey, claims["sub"])
		next.ServeHTTP(w, r.WithContext(ctx))
	}
}
