package repository

import (
	"context"
	"errors"
	"fmt"
	"time"

	"github.com/jackc/pgx/v4"
	"github.com/jmoiron/sqlx"
	"github.com/lib/pq"
	"github.com/sirupsen/logrus"
)

type Repo struct {
	conn *sqlx.DB
	log  *logrus.Logger
}

// New sets up a new Postgres repository.
func New(conn *sqlx.DB, log *logrus.Logger) *Repo {
	repo := &Repo{
		conn: conn,
		log:  log,
	}

	repo.conn = conn
	repo.log = log
	return repo
}

type Key struct {
	Account string
	PubKey  string
	PrivKey string
}

func (r *Repo) AddKey(ctx context.Context, key Key, encryptionKey string) error {
	createdAt := time.Now()
	query := `INSERT INTO
    	keys (id, created, pub_key, priv_key) 
	VALUES ($1, $2, pgp_sym_encrypt($3, $5), pgp_sym_encrypt($4, $5))`
	if _, err := r.conn.ExecContext(ctx, query, key.Account, createdAt, key.PubKey, key.PrivKey, encryptionKey); err != nil {
		var pgErr *pq.Error
		fmt.Printf("----ERR HAPPENED: %v\n", err)
		if errors.As(err, &pgErr) {
			if pgErr.Code.Name() == "unique_violation" {
				return ErrorDuplicateKey
			}
		}
		return fmt.Errorf("could not create new key: %w", err)
	}
	return nil
}

func (r *Repo) GetKeyByID(ctx context.Context, ID, encryptionKey string) (*Key, error) {
	row := r.conn.QueryRowContext(ctx, "SELECT id, pgp_sym_decrypt(pub_key::bytea, $2) as pub_key, pgp_sym_decrypt(priv_key::bytea, $2) as priv_key FROM keys where id = $1",
		ID, encryptionKey)
	if err := row.Err(); err != nil {
		if errors.Is(err, pgx.ErrNoRows) {
			return nil, ErrorKeyNotFound
		}
		return nil, err
	}
	k := Key{}
	if err := row.Scan(&k.Account, &k.PubKey, &k.PrivKey); err != nil {
		return nil, err
	}
	return &k, nil
}
