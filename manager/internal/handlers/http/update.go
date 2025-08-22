package http

import (
	"encoding/json"
	"fmt"
	"net/http"

	"github.com/go-chi/chi/v5"
)

type updateRecordRequest struct {
	ID    string `json:"-"`
	Value string `json:"value"`
}

func (ur *updateRecordRequest) Decode(r *http.Request) error {
	ur.ID = chi.URLParam(r, "id")
	if err := json.NewDecoder(r.Body).Decode(&ur); err != nil {
		return err
	}
	return ur.validate()
}
func (ur *updateRecordRequest) validate() error {
	if ur.ID == "" {
		return fmt.Errorf("empty id")
	}
	if ur.Value == "" {
		return fmt.Errorf("empty value")
	}
	return nil
}

type updateRecordResponse struct {
}

func (ur *updateRecordResponse) WriteTo(w http.ResponseWriter) error {
	return responseObject(w, http.StatusOK, nil)
}

func (h handler) updateRecord(r *http.Request) response {
	var req updateRecordRequest
	if err := req.Decode(r); err != nil {
		return errRequest(r, err)
	}
	accountID := r.Context().Value(UserCtxKey).(string)
	token := r.Context().Value(TokenCtxKey).(string)
	err := h.api.UpdateRecord(r.Context(), accountID, req.ID, req.Value, token)
	if err != nil {
		return errApi(r, "could not update record: %v", err)
	}
	return &updateRecordResponse{}
}
