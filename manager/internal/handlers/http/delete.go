package http

import (
	"fmt"
	"net/http"

	"github.com/go-chi/chi/v5"
)

type deleteRecordRequest struct {
	ID string
}

func (ur *deleteRecordRequest) Decode(r *http.Request) error {
	ur.ID = chi.URLParam(r, "id")
	return ur.validate()
}
func (ur *deleteRecordRequest) validate() error {
	if ur.ID == "" {
		return fmt.Errorf("empty id")
	}
	return nil
}

type deleteRecordResponse struct {
}

func (ur *deleteRecordResponse) WriteTo(w http.ResponseWriter) error {
	return responseObject(w, http.StatusNoContent, nil)
}

func (h handler) deleteRecord(r *http.Request) response {
	var req deleteRecordRequest
	if err := req.Decode(r); err != nil {
		return errRequest(r, err)
	}
	err := h.api.DeleteRecord(r.Context(), req.ID)
	if err != nil {
		return errApi(r, "could not delete record: %v", err)
	}
	return &deleteRecordResponse{}
}
