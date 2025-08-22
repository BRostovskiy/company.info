package http

import (
	"bytes"
	"crypto"
	"encoding/json"
	"errors"
	"fmt"
	"net/http"
	"time"

	"github.com/BorisRostovskiy/company.info/users/internal/service"
	"golang.org/x/crypto/openpgp"
	"golang.org/x/crypto/openpgp/armor"
	"golang.org/x/crypto/openpgp/packet"
)

type createUserRequest struct {
	Username  string `json:"username"`
	FirstName string `json:"first_name"`
	LastName  string `json:"last_name"`
	Email     string `json:"email"`
	Password  string `json:"password"`
}

func (lr *createUserRequest) Decode(r *http.Request) error {
	if err := json.NewDecoder(r.Body).Decode(&lr); err != nil {
		return err
	}
	return lr.validate()
}
func (lr *createUserRequest) validate() error {
	if lr.Username == "" {
		return fmt.Errorf("empty username")
	}
	if lr.Password == "" {
		return fmt.Errorf("empty password")
	}
	return nil
}

type createUserResponse struct {
	ID        string `json:"id"`
	Username  string `json:"username"`
	FirstName string `json:"first_name"`
	LastName  string `json:"last_name"`
	Email     string `json:"email"`
}

func (cp *createUserResponse) WriteTo(w http.ResponseWriter) error {
	return responseObject(w, http.StatusCreated, cp)
}

func (h handler) createUser(r *http.Request) response {
	var req createUserRequest
	if err := req.Decode(r); err != nil {
		return errRequest(r, err)
	}
	err := h.api.CreateKCUser(r.Context(), req.Username, req.Email, req.FirstName, req.LastName, req.Password)
	generateKeys := true
	if err != nil {
		if !errors.Is(err, service.ErrUserAlreadyExists) {
			return errApi(r, "could not create user: %v", err)
		}
		generateKeys = false
	}

	user, err := h.api.GetKCUserByEmail(r.Context(), req.Email)
	if err != nil {
		return errApi(r, "could not get new user: %v", err)
	}

	if generateKeys {
		var pubKey, privateKey string
		pubKey, privateKey, err = createPGPKeys(req.Username, req.Email)
		if err != nil {
			return errApi(r, "could not generate user keys: %v", err)
		}
		err = h.api.AddKey(r.Context(), user.ID, pubKey, privateKey)
		if err != nil {
			return errApi(r, "could not add user keys: %v", err)
		}
	}
	return &createUserResponse{
		ID:        user.ID,
		FirstName: user.FirstName,
		LastName:  user.LastName,
		Username:  user.Username,
		Email:     user.Email,
	}
}

func createPGPKeys(name, email string) (string, string, error) {
	cfg := &packet.Config{
		DefaultHash:   crypto.SHA256,
		DefaultCipher: packet.CipherAES256,
		RSABits:       4096,
		Time:          time.Now,
	}

	// Generate a new PGP entity
	entity, err := openpgp.NewEntity(name, "Generated with Go", email, cfg)
	if err != nil {
		return "", "", err
	}

	for _, id := range entity.Identities {
		if err = id.SelfSignature.SignUserId(id.UserId.Id, entity.PrimaryKey, entity.PrivateKey, nil); err != nil {
			return "", "", err
		}
	}

	var pubKey bytes.Buffer
	pubWriter, err := armor.Encode(&pubKey, openpgp.PublicKeyType, nil)
	if err != nil {
		return "", "", err
	}
	err = entity.Serialize(pubWriter)
	if err != nil {
		return "", "", err
	}
	_ = pubWriter.Close()

	var privKey bytes.Buffer
	privWriter, err := armor.Encode(&privKey, openpgp.PrivateKeyType, nil)
	if err != nil {
		return "", "", err
	}
	err = entity.SerializePrivate(privWriter, nil)
	if err != nil {
		return "", "", err
	}
	_ = privWriter.Close()
	return pubKey.String(), privKey.String(), nil
}
