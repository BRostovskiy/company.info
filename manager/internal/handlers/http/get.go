package http

import (
	"fmt"
	"net/http"
	"time"

	"github.com/go-chi/chi/v5"

	"github.com/BorisRostovskiy/company.info/manager/internal/service"
)

type recordsListResponse []service.Record

func (cr recordsListResponse) WriteTo(w http.ResponseWriter) error {
	return responseObject(w, http.StatusCreated, cr)
}

func (h handler) getRecords(r *http.Request) response {
	accountID := r.Context().Value(UserCtxKey).(string)
	resp, err := h.api.GetRecords(r.Context(), accountID)
	if err != nil {
		return errApi(r, "could not get records list: %v", err)
	}
	result := make(recordsListResponse, len(resp))
	for i := range resp {
		result[i] = resp[i]
	}
	return &result
}

type getRecordRequest struct {
	ID string
}

func (gr *getRecordRequest) Decode(r *http.Request) error {
	gr.ID = chi.URLParam(r, "id")
	return gr.validate()
}
func (gr *getRecordRequest) validate() error {
	if gr.ID == "" {
		return fmt.Errorf("empty id")
	}
	return nil
}

type getRecordResponse struct {
	ID      string    `json:"id"`
	Name    string    `json:"name"`
	Value   string    `json:"value"`
	Created time.Time `json:"created"`
}

func (gr *getRecordResponse) WriteTo(w http.ResponseWriter) error {
	return responseObject(w, http.StatusCreated, gr)
}

func (h handler) getRecord(r *http.Request) response {
	var req getRecordRequest
	if err := req.Decode(r); err != nil {
		return errRequest(r, err)
	}
	accountID := r.Context().Value(UserCtxKey).(string)
	token := r.Context().Value(TokenCtxKey).(string)
	res, err := h.api.GetRecordDecrypted(r.Context(), accountID, req.ID, token)
	if err != nil {
		return errApi(r, "could not get record: %v", err)
	}
	return &getRecordResponse{
		ID:      res.ID,
		Name:    res.Name,
		Value:   res.Value,
		Created: res.Created,
	}
}
