package clients

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"io"
	"log"
	"net/http"
	"net/url"
	"strings"
	"time"

	"github.com/MicahParks/keyfunc"
	"github.com/golang-jwt/jwt/v4"
)

const (
	contentTypeUrlEncoded = "application/x-www-form-urlencoded"
	contentTypeJSON       = "application/json"
)

type Config struct {
	BaseURL        string
	Realm          string
	ClientID       string
	ClientSecret   string
	RequestTimeout time.Duration
}

type Keycloak struct {
	jwks *keyfunc.JWKS
	cfg  Config
}

func NewKeycloak(cfg Config) (*Keycloak, error) {
	jwks, err := getJWKS(cfg.BaseURL, cfg.Realm)
	if err != nil {
		return nil, fmt.Errorf("could not get JWKS: %w", err)
	}
	return &Keycloak{jwks: jwks, cfg: cfg}, nil
}

func (kc *Keycloak) CreateKCUser(ctx context.Context, userName, email, firstName, lastName, password string) error {
	payload, err := json.Marshal(struct {
		UN      string           `json:"username"`
		FN      string           `json:"firstName"`
		LN      string           `json:"lastName"`
		Email   string           `json:"email"`
		Enabled bool             `json:"enabled"`
		Cred    []map[string]any `json:"credentials"`
	}{
		UN: userName, FN: firstName, LN: lastName, Email: email, Enabled: true,
		Cred: []map[string]any{
			{"type": "password", "value": password, "temporary": false}},
	})
	if err != nil {
		return NewError(ErrCodeBadRequest, fmt.Sprintf("could not marshal user: %v", err))
	}

	token, err := kc.getServiceAccountToken(ctx)
	if err != nil {
		return err
	}
	adminURL := fmt.Sprintf("%s/admin/realms/%s/users", kc.cfg.BaseURL, kc.cfg.Realm)
	resp, err := doPost(ctx, adminURL, contentTypeJSON, bytes.NewReader(payload), &token)
	if err != nil {
		return NewError(ErrCodeInternalError, fmt.Sprintf("could not create user: %v", err))
	} else if resp.StatusCode != http.StatusCreated {
		switch resp.StatusCode {
		// 409 - ok, duplicate entry
		case http.StatusConflict:
			return ErrUserAlreadyExists
		case http.StatusBadRequest:
			return NewError(ErrCodeBadRequest, "could not process create user request: bad request")
		default:
			return NewError(ErrCodeBadRequest, fmt.Sprintf("could not process create user request: %d statusCode", resp.StatusCode))
		}
	}

	defer func() { _ = resp.Body.Close() }()
	return nil
}

func (kc *Keycloak) GetKCUserByEmail(ctx context.Context, email string) ([]byte, error) {
	token, err := kc.getServiceAccountToken(ctx)
	if err != nil {
		return nil, err
	}
	reqURL := fmt.Sprintf("%s/admin/realms/%s/users?email=%s", kc.cfg.BaseURL, kc.cfg.Realm, email)
	req, err := http.NewRequest(http.MethodGet, reqURL, nil)
	if err != nil {
		return nil, NewError(ErrCodeBadRequest, "could not perform search by email")
	}
	req = req.WithContext(ctx)
	req.Header.Set("Authorization", "Bearer "+token)

	client := http.DefaultClient
	resp, err := client.Do(req)
	if err != nil {
		return nil, err
	}
	if resp.StatusCode != http.StatusOK {
		return nil, NewError(ErrCodeBadRequest, fmt.Sprintf("user not found by email: %s", email))
	}
	defer func() { _ = resp.Body.Close() }()
	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return nil, NewError(ErrCodeInternalError, fmt.Sprintf("could not read user body: %v", err))
	}
	return body, nil
}

func (kc *Keycloak) LoginToKC(ctx context.Context, userName, userPWD string) ([]byte, error) {
	form := url.Values{}
	form.Set("grant_type", "password")
	form.Set("client_id", kc.cfg.ClientID)
	form.Set("client_secret", kc.cfg.ClientSecret)
	form.Set("username", userName)
	form.Set("password", userPWD)

	loginURL := fmt.Sprintf("%s/realms/%s/protocol/openid-connect/token", kc.cfg.BaseURL, kc.cfg.Realm)
	ctx, cancel := context.WithTimeout(ctx, kc.cfg.RequestTimeout)
	defer cancel()
	resp, err := doPost(ctx, loginURL, contentTypeUrlEncoded, strings.NewReader(form.Encode()), nil)
	if err != nil {
		return nil, fmt.Errorf("error during login request: %w", err)
	}
	defer func() { _ = resp.Body.Close() }()
	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return nil, fmt.Errorf("could not read login body: %w", err)
	}
	return body, nil
}

func (kc *Keycloak) LogoutFromKC(ctx context.Context, refreshToken string) error {
	form := url.Values{}
	form.Set("client_id", kc.cfg.ClientID)
	form.Set("client_secret", kc.cfg.ClientSecret)
	form.Set("refresh_token", refreshToken)

	logoutURL := fmt.Sprintf("%s/realms/%s/protocol/openid-connect/logout", kc.cfg.BaseURL, kc.cfg.Realm)
	resp, err := doPost(ctx, logoutURL, contentTypeUrlEncoded, strings.NewReader(form.Encode()), nil)
	if err != nil {
		return NewError(ErrCodeInternalError, fmt.Sprintf("error during logout request: %v", err))
	}

	defer func() { _ = resp.Body.Close() }()
	if resp.StatusCode != http.StatusNoContent && resp.StatusCode != http.StatusOK {
		body, _ := io.ReadAll(resp.Body)
		return NewError(ErrCodeInternalError, fmt.Sprintf("status code not ok: %d, body: %s", resp.StatusCode, string(body)))
	}
	return nil
}

func (kc *Keycloak) VerifyKCToken(token string) (jwt.MapClaims, error) {
	if kc.jwks == nil {
		return nil, ErrValidateJWTNotInitialized
	}
	parsed, err := jwt.Parse(token, kc.jwks.Keyfunc)
	if err != nil {
		return nil, NewError(ErrCodeValidateJWTParse, fmt.Sprintf("could not parse JWT: %v", err))
	}
	if !parsed.Valid {
		return nil, ErrValidateJWTNotValid
	}
	claims, ok := parsed.Claims.(jwt.MapClaims)
	if !ok {
		return nil, ErrValidateJWTInvalidClaims
	}
	return claims, nil
}

// getServiceAccountToken uses client credentials grant to get an admin token.
func (kc *Keycloak) getServiceAccountToken(ctx context.Context) (string, error) {
	form := url.Values{}
	form.Set("grant_type", "client_credentials")
	form.Set("client_id", kc.cfg.ClientID)
	form.Set("client_secret", kc.cfg.ClientSecret)

	tokenURL := fmt.Sprintf("%s/realms/%s/protocol/openid-connect/token", kc.cfg.BaseURL, kc.cfg.Realm)
	req, err := http.NewRequest(http.MethodPost, tokenURL, strings.NewReader(form.Encode()))
	if err != nil {
		return "", fmt.Errorf("could not create login request: %w", err)
	}
	req.Header.Set("Content-Type", contentTypeUrlEncoded)
	ctx, cancel := context.WithTimeout(ctx, kc.cfg.RequestTimeout)
	defer cancel()
	req = req.WithContext(ctx)

	client := http.DefaultClient
	resp, err := client.Do(req)
	defer func() { _ = resp.Body.Close() }()
	if resp.StatusCode != 200 {
		return "", fmt.Errorf("token request failed: %s", resp.Status)
	}
	var out struct {
		AccessToken string `json:"access_token"`
	}
	if err = json.NewDecoder(resp.Body).Decode(&out); err != nil {
		return "", fmt.Errorf("failed to decode access token: %w", err)
	}
	return out.AccessToken, nil
}

func doPost(ctx context.Context, epURL string, contentType string, payload io.Reader, authorization *string) (*http.Response, error) {
	req, err := http.NewRequest(http.MethodPost, epURL, payload)
	if err != nil {
		return nil, err
	}
	req.Header.Set("Content-Type", contentType)
	req = req.WithContext(ctx)
	if authorization != nil {
		req.Header.Set("Authorization", "Bearer "+*authorization)
	}
	client := http.DefaultClient
	return client.Do(req)
}

// JWKS stands for "JSON Web Key Set". Keycloak publishes its public keys in JWKS format so that client applications can verify the JWTs it issues
func getJWKS(baseURL, realm string) (*keyfunc.JWKS, error) {
	jwksURL := fmt.Sprintf("%s/realms/%s/protocol/openid-connect/certs", baseURL, realm)
	options := keyfunc.Options{
		RefreshErrorHandler: func(err error) {
			log.Printf("JWKS refresh error: %v", err)
		},
		RefreshInterval:   time.Hour,
		RefreshTimeout:    10 * time.Second,
		RefreshUnknownKID: true,
	}
	return keyfunc.Get(jwksURL, options)
}
