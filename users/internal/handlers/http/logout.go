package http

import (
	"encoding/json"
	"fmt"
	"net/http"
)

type logoutRequest struct {
	RefreshToken string `json:"refresh_token"`
}

func (lr *logoutRequest) Decode(r *http.Request) error {
	if err := json.NewDecoder(r.Body).Decode(&lr); err != nil {
		return err
	}
	return lr.validate()
}

func (lr *logoutRequest) validate() error {
	if lr.RefreshToken == "" {
		return fmt.Errorf("missing refresh_token")
	}
	return nil
}

type logoutResponse struct {
	Status string
}

func (cp *logoutResponse) WriteTo(w http.ResponseWriter) error {
	cp.Status = "logged out"
	return responseObject(w, http.StatusOK, cp)
}

func (h handler) logout(r *http.Request) response {
	var req logoutRequest
	if err := req.Decode(r); err != nil {
		return errRequest(r, err)
	}
	if err := h.api.LogoutFromKC(r.Context(), req.RefreshToken); err != nil {
		return errApi(r, "could not logout from keycloak: %v", err)
	}
	return &logoutResponse{}
}
