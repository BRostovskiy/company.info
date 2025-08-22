package http

import (
	"fmt"
	"net/http"
)

type getUserKeysRequest struct {
	ID string
}

func (gu *getUserKeysRequest) Decode(r *http.Request) error {
	gu.ID = r.Context().Value(UserCtxKey).(string)
	return gu.validate()
}
func (gu *getUserKeysRequest) validate() error {
	if gu.ID == "" {
		return fmt.Errorf("empty ID")
	}
	return nil
}

type getUserKeysResponse struct {
	Pub     string `json:"public_key"`
	Private string `json:"private_key"`
}

func (gu *getUserKeysResponse) WriteTo(w http.ResponseWriter) error {
	return responseObject(w, http.StatusOK, gu)
}

func (h handler) getUserKeys(r *http.Request) response {
	var req getUserKeysRequest
	if err := req.Decode(r); err != nil {
		return errRequest(r, err)
	}

	pub, private, err := h.api.GetKeyByID(r.Context(), req.ID)
	if err != nil {
		return errApi(r, "could not get user keys: %v", err)
	}
	return &getUserKeysResponse{Pub: pub, Private: private}
}
