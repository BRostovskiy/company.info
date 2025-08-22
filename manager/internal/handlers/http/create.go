package http

import (
	"encoding/json"
	"fmt"
	"net/http"
)

type createRecordRequest struct {
	Name  string `json:"name"`
	Value string `json:"value"`
}

func (cr *createRecordRequest) Decode(r *http.Request) error {
	if err := json.NewDecoder(r.Body).Decode(&cr); err != nil {
		return err
	}
	return cr.validate()
}
func (cr *createRecordRequest) validate() error {
	if cr.Name == "" {
		return fmt.Errorf("empty name")
	}
	if cr.Value == "" {
		return fmt.Errorf("empty value")
	}
	return nil
}

type createRecordResponse struct {
	ID string `json:"id"`
}

func (cr *createRecordResponse) WriteTo(w http.ResponseWriter) error {
	return responseObject(w, http.StatusCreated, cr)
}

func (h handler) createRecord(r *http.Request) response {
	var req createRecordRequest
	if err := req.Decode(r); err != nil {
		return errRequest(r, err)
	}
	accountID := r.Context().Value(UserCtxKey).(string)
	token := r.Context().Value(TokenCtxKey).(string)
	res, err := h.api.CreateRecord(r.Context(), accountID, req.Name, req.Value, token)
	if err != nil {
		return errApi(r, "could not create new record: %v", err)
	}
	return &createRecordResponse{
		ID: res,
	}
}
