package service

import (
	"context"
	"encoding/json"
	"fmt"
	"time"

	"github.com/BorisRostovskiy/company.info/users/internal/repository"
	"github.com/golang-jwt/jwt/v4"
)

type Config struct {
	Secret string
}

type Repository interface {
	AddKey(ctx context.Context, key repository.Key, Secret string) error
	GetKeyByID(ctx context.Context, ID, Secret string) (*repository.Key, error)
}

type KeycloakCaller interface {
	CreateKCUser(ctx context.Context, userName, email, firstName, lastName, password string) error
	GetKCUserByEmail(ctx context.Context, email string) ([]byte, error)
	LoginToKC(ctx context.Context, userName, userPWD string) ([]byte, error)
	LogoutFromKC(ctx context.Context, refreshToken string) error
	VerifyKCToken(token string) (jwt.MapClaims, error)
}

type APICaller struct {
	kcClient KeycloakCaller
	repo     Repository
	cfg      Config
}

func New(cfg Config, repo Repository, kc KeycloakCaller) *APICaller {
	return &APICaller{
		cfg:      cfg,
		repo:     repo,
		kcClient: kc,
	}
}

func (ac *APICaller) CreateKCUser(ctx context.Context, userName, email, firstName, lastName, password string) error {
	return ac.kcClient.CreateKCUser(ctx, userName, email, firstName, lastName, password)
}

type GetUserResponse struct {
	ID        string `json:"id"`
	Username  string `json:"username"`
	FirstName string `json:"firstName"`
	LastName  string `json:"lastName"`
	Email     string `json:"email"`
}

func (ac *APICaller) GetKCUserByEmail(ctx context.Context, email string) (*GetUserResponse, error) {
	body, err := ac.kcClient.GetKCUserByEmail(ctx, email)
	if err != nil {
		return nil, err
	}
	result := make([]GetUserResponse, 0)
	err = json.Unmarshal(body, &result)
	if err != nil {
		return nil, NewError(ErrCodeInternalError, fmt.Sprintf("could not unmarshal user body: %v", err))
	}
	if l := len(result); l != 1 {
		return nil, NewError(ErrCodeInternalError, fmt.Sprintf("number of users is too ambigous: %d", l))
	}
	return &result[0], nil
}

type LoginResponse struct {
	AccessToken      string        `json:"access_token"`
	ExpiresIn        time.Duration `json:"expires_in"`
	RefreshToken     string        `json:"refresh_token"`
	RefreshExpiresIn time.Duration `json:"refresh_expires_in"`
}

func (ac *APICaller) LoginToKC(ctx context.Context, userName, userPWD string) (*LoginResponse, error) {
	body, err := ac.kcClient.LoginToKC(ctx, userName, userPWD)
	if err != nil {
		return nil, NewError(ErrCodeInternalError, fmt.Sprintf("could not read login body: %v", err))
	}
	var result LoginResponse
	err = json.Unmarshal(body, &result)
	if err != nil {
		return nil, NewError(ErrCodeInternalError, fmt.Sprintf("could not unmarshal login body: %v", err))
	}
	return &result, nil
}

func (ac *APICaller) LogoutFromKC(ctx context.Context, refreshToken string) error {
	return ac.kcClient.LogoutFromKC(ctx, refreshToken)
}

func (ac *APICaller) VerifyKCToken(token string) (jwt.MapClaims, error) {
	return ac.kcClient.VerifyKCToken(token)
}

func (ac *APICaller) AddKey(ctx context.Context, acc, pubKey, privateKey string) error {
	return ac.repo.AddKey(ctx, repository.Key{Account: acc, PubKey: pubKey, PrivKey: privateKey}, ac.cfg.Secret)
}

func (ac *APICaller) GetKeyByID(ctx context.Context, ID string) (string, string, error) {
	k, err := ac.repo.GetKeyByID(ctx, ID, ac.cfg.Secret)
	if err != nil {
		return "", "", err
	}
	return k.PubKey, k.PrivKey, nil
}
