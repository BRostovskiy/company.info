package users

import (
	"context"
	"encoding/json"
	"fmt"
	"net/http"
	"time"
)

type Config struct {
	URL            string
	RequestTimeout time.Duration
}

type Client struct {
	cfg Config
}

func New(cfg Config) *Client {
	return &Client{cfg: cfg}
}

type GetUserKeysResponse struct {
	PublicKey  string `json:"public_key"`
	PrivateKey string `json:"private_key"`
}

func (c *Client) GetUserKeys(ctx context.Context, ID, token string) (*GetUserKeysResponse, error) {
	reqURL := fmt.Sprintf("%s/service/v1/users/keys", c.cfg.URL)
	resp, err := doGet(ctx, reqURL, token)
	if err != nil {
		return nil, err
	}
	if resp.StatusCode != http.StatusOK {
		return nil, NewError(ErrCodeBadRequest, fmt.Sprintf("could not get user keys: %d", resp.StatusCode))
	}
	defer func() { _ = resp.Body.Close() }()
	var result GetUserKeysResponse
	if err = json.NewDecoder(resp.Body).Decode(&result); err != nil {
		return nil, fmt.Errorf("could not decode verify response: %w", err)
	}
	return &result, nil
}

type VerifyResponse struct {
	Valid      bool   `json:"valid"`
	Expiration any    `json:"exp"`
	Subject    string `json:"sub"`
	Audience   any    `json:"aud"`
}

func (c *Client) VerifyJWTToken(ctx context.Context, token string) (*VerifyResponse, error) {
	reqURL := fmt.Sprintf("%s/service/v1/token/verify", c.cfg.URL)
	resp, err := doGet(ctx, reqURL, token)
	if err != nil {
		return nil, err
	}
	if resp.StatusCode != http.StatusOK {
		return nil, NewError(ErrCodeBadRequest, fmt.Sprintf("could not verify token: %d", resp.StatusCode))
	}
	defer func() { _ = resp.Body.Close() }()
	var result VerifyResponse
	if err = json.NewDecoder(resp.Body).Decode(&result); err != nil {
		return nil, fmt.Errorf("could not decode verify response: %w", err)
	}
	return &result, nil
}

func doGet(ctx context.Context, reqURL, authToken string) (*http.Response, error) {
	req, err := http.NewRequest(http.MethodGet, reqURL, nil)
	if err != nil {
		return nil, NewError(ErrCodeBadRequest, "could not perform get request")
	}
	req = req.WithContext(ctx)
	req.Header.Set("Authorization", "Bearer "+authToken)

	client := http.DefaultClient
	return client.Do(req)
}
