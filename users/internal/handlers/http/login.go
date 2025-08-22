package http

import (
	"encoding/json"
	"fmt"
	"net/http"

	"github.com/BorisRostovskiy/company.info/users/internal/service"
)

type loginRequest struct {
	Username string `json:"username"`
	Password string `json:"password"`
}

func (lr *loginRequest) Decode(r *http.Request) error {
	if err := json.NewDecoder(r.Body).Decode(&lr); err != nil {
		return err
	}
	return lr.validate()
}
func (lr *loginRequest) validate() error {
	if lr.Username == "" {
		return fmt.Errorf("empty username")
	}
	if lr.Password == "" {
		return fmt.Errorf("empty password")
	}
	return nil
}

type loginResponse struct {
	service.LoginResponse
}

func (cp *loginResponse) WriteTo(w http.ResponseWriter) error {
	return responseObject(w, http.StatusOK, cp)
}

func (h handler) login(r *http.Request) response {
	var req loginRequest
	if err := req.Decode(r); err != nil {
		return errRequest(r, err)
	}
	resp, err := h.api.LoginToKC(r.Context(), req.Username, req.Password)
	if err != nil {
		return errApi(r, "could not login to keycloak: %v", err)
	}
	if resp == nil {
		return errApi(r, "login response is empty")
	}
	return &loginResponse{LoginResponse: *resp}
}
