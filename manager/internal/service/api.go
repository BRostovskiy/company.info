package service

import (
	"context"
	"errors"
	"fmt"

	"github.com/BorisRostovskiy/company.info/manager/clients/users"
	"github.com/BorisRostovskiy/company.info/manager/internal/repository"
)

type Repository interface {
	Create(ctx context.Context, accountID, name, value, pubKey string) (string, error)
	GetAll(ctx context.Context, accountID string) ([]repository.Record, error)
	GetOne(ctx context.Context, ID, privateKey string) (*repository.Record, error)
	Update(ctx context.Context, ID string, newValue, pubKey string) error
	Delete(ctx context.Context, ID string) error
}

type UsersCaller interface {
	GetUserKeys(ctx context.Context, ID, token string) (*users.GetUserKeysResponse, error)
	VerifyJWTToken(ctx context.Context, token string) (*users.VerifyResponse, error)
}

type APICaller struct {
	users UsersCaller
	repo  Repository
}

func New(repo Repository, users UsersCaller) *APICaller {
	return &APICaller{
		repo:  repo,
		users: users,
	}
}

func (ac *APICaller) VerifyJWTToken(ctx context.Context, token string) (string, error) {
	res, err := ac.users.VerifyJWTToken(ctx, token)
	if err != nil {
		return "", NewError(ErrCodeBadRequest, fmt.Sprintf("could not verify token: %v", err))
	}
	return res.Subject, nil
}

func (ac *APICaller) CreateRecord(ctx context.Context, accountID, name, value, token string) (string, error) {
	keys, err := ac.users.GetUserKeys(ctx, accountID, token)
	if err != nil {
		return "", NewError(ErrCodeInternalError, fmt.Sprintf("could not create record: %v", err))
	}

	return ac.repo.Create(ctx, accountID, name, value, keys.PublicKey)
}

func (ac *APICaller) GetRecords(ctx context.Context, accountID string) ([]Record, error) {
	records, err := ac.repo.GetAll(ctx, accountID)
	if err != nil {
		return nil, NewError(ErrCodeInternalError, fmt.Sprintf("could not get records: %v", err))
	}
	result := make([]Record, len(records))
	for i, r := range records {
		result[i] = Record{
			ID:      r.ID,
			Name:    r.Name,
			Value:   r.Value,
			Created: r.Created,
		}
	}
	return result, nil
}

func (ac *APICaller) GetRecordDecrypted(ctx context.Context, accountID, recordID, token string) (*Record, error) {
	keys, err := ac.users.GetUserKeys(ctx, accountID, token)
	if err != nil {
		return nil, NewError(ErrCodeInternalError, fmt.Sprintf("could not get record: %v", err))
	}
	r, err := ac.repo.GetOne(ctx, recordID, keys.PrivateKey)
	if err != nil {
		if errors.Is(err, repository.ErrorRecordNotFound) {
			return nil, ErrNotFound
		}
		return nil, NewError(ErrCodeInternalError, fmt.Sprintf("could not fetch record: %v", err))
	}
	return &Record{
		ID:      r.ID,
		Name:    r.Name,
		Value:   r.Value,
		Created: r.Created,
	}, nil
}

func (ac *APICaller) UpdateRecord(ctx context.Context, accountID, recordID string, newValue, token string) error {
	keys, err := ac.users.GetUserKeys(ctx, accountID, token)
	if err != nil {
		return NewError(ErrCodeInternalError, fmt.Sprintf("could not updaye record: %v", err))
	}
	return ac.repo.Update(ctx, recordID, newValue, keys.PublicKey)
}

func (ac *APICaller) DeleteRecord(ctx context.Context, ID string) error {
	return ac.repo.Delete(ctx, ID)
}
