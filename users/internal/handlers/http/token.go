package http

import (
	"fmt"
	"net/http"
	"strings"
)

type verifyRequest struct {
	Token string
}

func (vr *verifyRequest) Decode(r *http.Request) error {
	vr.Token = strings.TrimPrefix(r.Header.Get("Authorization"), "Bearer ")
	return vr.validate()
}
func (vr *verifyRequest) validate() error {
	if vr.Token == "" {
		return fmt.Errorf("empty token")
	}
	return nil
}

type verifyResponse struct {
	Valid      bool   `json:"valid"`
	Expiration any    `json:"exp"`
	Subject    string `json:"sub"`
	Audience   any    `json:"aud"`
}

func (vr *verifyResponse) WriteTo(w http.ResponseWriter) error {
	return responseObject(w, http.StatusOK, vr)
}

func (h handler) verifyToken(r *http.Request) response {
	var req verifyRequest
	if err := req.Decode(r); err != nil {
		return errRequest(r, err)
	}

	claims, err := h.api.VerifyKCToken(req.Token)
	if err != nil {
		return errApi(r, "could not verify JWT token: %v", err)
	}
	return &verifyResponse{
		Valid:      true,
		Expiration: claims["exp"],
		Subject:    claims["sub"].(string),
		Audience:   claims["aud"],
	}
}
