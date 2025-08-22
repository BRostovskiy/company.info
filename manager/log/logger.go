package log

import (
	"fmt"
	"net"
	//"net"
	"net/http"
	"time"

	"github.com/go-chi/chi/v5/middleware"
	"github.com/sirupsen/logrus"
)

type LogEntry interface {
	middleware.LogEntry
	WithError(err error) LogEntry
	WithPrefix(p string) LogEntry
}

func GetLogEntry(r *http.Request) LogEntry {
	entry, _ := middleware.GetLogEntry(r).(LogEntry)
	return entry
}

func WithError(r *http.Request, err error) {
	if entry := GetLogEntry(r); entry != nil {
		entry.WithError(err)
	}
}

func WithErrorf(r *http.Request, format string, a ...interface{}) error {
	err := fmt.Errorf(format, a...)
	if le := GetLogEntry(r); le != nil {
		le.WithError(err)
	}
	return err
}

type LogFormatter struct {
	Logger *logrus.Logger
}

func (lf *LogFormatter) NewLogEntry(r *http.Request) middleware.LogEntry {
	return &logEntry{
		log: lf.Logger.WithFields(logrus.Fields{"METHOD": r.Method, "REQUEST_URI": r.RequestURI}).Logger, //lf.Logger.WithPrefix(r.Method).WithPrefix(r.RequestURI).WithPrefix(r.RemoteAddr),
	}
}

type logEntry struct {
	log *logrus.Logger
	err []error
}

func (en *logEntry) Write(status, bytes int, header http.Header, elapsed time.Duration, extra interface{}) {
	var printf func(format string, v ...interface{})

	switch {
	case status < 400:
		printf = en.log.Infof
	case status < 500:
		printf = en.log.Warnf
	default:
		printf = en.log.Errorf
	}

	text := http.StatusText(status)
	if en.err != nil {
		var err string
		for i := len(en.err) - 1; i >= 0; i-- {
			if len(err) > 0 {
				err += " | "
			}
			err += en.err[i].Error()
		}
		printf("%03d (%s) in %s - %v", status, text, elapsed, err)
	} else {
		printf("%03d (%s) in %s", status, text, elapsed)
	}
}

func (en *logEntry) Panic(v interface{}, stack []byte) {
	middleware.PrintPrettyStack(v)
}

func (en *logEntry) WithPrefix(p string) LogEntry {
	//	en.log.
	//	if len(p) > 0 {
	//		en.log = en.log.WithPrefix(p)
	//	}
	return en
}

func (en *logEntry) WithError(err error) LogEntry {
	if err != nil {
		en.err = append(en.err, err)
	}
	return en
}

// LoggerWithLevel returns a request logging middleware
func LoggerWithLevel(component string, logger logrus.FieldLogger, level logrus.Level) func(h http.Handler) http.Handler {
	return func(h http.Handler) http.Handler {
		fn := func(w http.ResponseWriter, r *http.Request) {
			reqID := middleware.GetReqID(r.Context())
			ww := middleware.NewWrapResponseWriter(w, r.ProtoMajor)
			t1 := time.Now()
			defer func() {
				remoteIP, _, err := net.SplitHostPort(r.RemoteAddr)
				if err != nil {
					remoteIP = r.RemoteAddr
				}

				fields := logrus.Fields{
					"status_code":      ww.Status(),
					"bytes":            ww.BytesWritten(),
					"duration_display": time.Since(t1).String(),
					"component":        component,
					"remote_ip":        remoteIP,
					"proto":            r.Proto,
					"method":           r.Method,
				}
				if len(reqID) > 0 {
					fields["request_id"] = reqID
				}

				logger.
					WithField("uri", fmt.Sprintf("%s%s", r.Host, r.RequestURI)).
					WithFields(fields).Log(level)
			}()

			h.ServeHTTP(ww, r)
		}

		return http.HandlerFunc(fn)
	}
}
