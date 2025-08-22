package http

import (
	"io"
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"

	"github.com/BorisRostovskiy/company.info/users/internal/service"
	"github.com/sirupsen/logrus"
	"github.com/stretchr/testify/assert"
	"go.uber.org/mock/gomock"
)

func TestLogin(t *testing.T) {
	t.Parallel()

	ctrl := gomock.NewController(t)
	defer ctrl.Finish()

	repo := service.NewMockRepository(ctrl)
	client := service.NewMockKeycloakCaller(ctrl)
	api := service.New(service.Config{Secret: "123"}, repo, client)
	log := logrus.New()
	tests := []struct {
		name       string
		cfg        *Config
		log        *logrus.Logger
		api        APICallerService
		expect     int
		clientMock func(r *service.MockKeycloakCaller)
		repoMock   func(r *service.MockRepository)
	}{
		{
			name:   "Login OK",
			cfg:    &Config{},
			log:    log,
			api:    api,
			expect: 200,
			clientMock: func(r *service.MockKeycloakCaller) {
				resp := []byte(`{"access_token": "123", "refresh_token": "321", "expires_in": 300, "refresh_expires_in": 1800}`)
				r.EXPECT().LoginToKC(gomock.Any(), "i.ivanov", "Qwerty!23").Return(resp, nil)
			},
			repoMock: func(r *service.MockRepository) {},
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			h := &handler{
				cfg: tt.cfg,
				log: tt.log,
				api: tt.api,
			}
			tt.clientMock(client)
			tt.repoMock(repo)

			r := router(h, log)
			payload := strings.NewReader(`{"username": "i.ivanov", "password": "Qwerty!23"}`)
			w := performRequest(r, http.MethodPost, "/service/v1/users/login", "application/json", payload)
			assert.Equal(t, tt.expect, w.Code)
		})
	}
}

func performRequest(r http.Handler, method, path, contentType string, body io.Reader) *httptest.ResponseRecorder {
	req, _ := http.NewRequest(method, path, body)
	if contentType != "" {
		req.Header.Add("Content-Type", contentType)
	}

	w := httptest.NewRecorder()
	r.ServeHTTP(w, req)
	return w
}
