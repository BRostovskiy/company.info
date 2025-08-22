package repository

import (
	"context"
	"errors"
	"fmt"
	"time"

	"github.com/google/uuid"
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

type Record struct {
	ID      string
	Account string
	Name    string
	Value   string
	Created time.Time
}

func (r *Repo) Create(ctx context.Context, accountID, name, value, pubKey string) (string, error) {
	createdAt := time.Now()
	id, err := uuid.NewUUID()
	if err != nil {
		return "", fmt.Errorf("could not generate record id: %w", err)
	}
	query := `INSERT INTO records (id, account, name, value, created)  VALUES ($1, $2, $3, pgp_pub_encrypt($4, dearmor($6)), $5)`
	if _, err = r.conn.ExecContext(ctx, query, id.String(), accountID, name, value, createdAt, pubKey); err != nil {
		var pgErr *pq.Error
		if errors.As(err, &pgErr) {
			if pgErr.Code.Name() == "unique_violation" {
				return "", ErrorDuplicateKey
			}
		}
		return "", fmt.Errorf("could not create new record: %w", err)
	}
	return id.String(), nil
}
func (r *Repo) GetAll(ctx context.Context, accountID string) ([]Record, error) {
	rows, err := r.conn.QueryContext(ctx, `SELECT id, name, value, created FROM records WHERE account=$1`, accountID)
	if err != nil {
		if errors.Is(err, pgx.ErrNoRows) {
			return nil, ErrorRecordNotFound
		}
		return nil, fmt.Errorf("could not fetch records: %w", err)
	}

	defer func() { _ = rows.Close() }()
	result := make([]Record, 0)
	for rows.Next() {
		var rec Record
		if err = rows.Scan(&rec.ID, &rec.Name, &rec.Value, &rec.Created); err != nil {
			return nil, fmt.Errorf("could not scan record: %w", err)
		}
		result = append(result, rec)
	}
	return result, rows.Err()
}
func (r *Repo) GetOne(ctx context.Context, ID, privateKey string) (*Record, error) {
	row := r.conn.QueryRowContext(ctx, "SELECT id, name, pgp_pub_decrypt(value::bytea, dearmor($2)) as value, created FROM records where id = $1",
		ID, privateKey)
	if err := row.Err(); err != nil {
		if errors.Is(err, pgx.ErrNoRows) {
			return nil, ErrorRecordNotFound
		}
		return nil, err
	}
	rec := Record{}
	if err := row.Scan(&rec.ID, &rec.Name, &rec.Value, &rec.Created); err != nil {
		return nil, err
	}
	return &rec, nil
}
func (r *Repo) Update(ctx context.Context, ID string, newValue, pubKey string) error {
	query := `UPDATE records SET value =  pgp_pub_encrypt($2, dearmor($3)) WHERE id=$1`
	if _, err := r.conn.ExecContext(ctx, query, ID, newValue, pubKey); err != nil {
		return fmt.Errorf("could not update record: %w", err)
	}
	return nil
}
func (r *Repo) Delete(ctx context.Context, ID string) error {
	if _, err := r.conn.ExecContext(ctx, `DELETE FROM records WHERE id=$1`, ID); err != nil {
		return err
	}
	return nil
}
