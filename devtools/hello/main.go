package main

import (
	"log"
	"net/http"
	"time"
)

func main() {
	log.Println("Server listening on port 8080")
	server := http.Server{
		Addr:              ":8080",
		ReadHeaderTimeout: 60 * time.Second,
		Handler: http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			_, _ = w.Write([]byte("Hello World!!"))
		}),
	}
	if err := server.ListenAndServe(); err != nil && err != http.ErrServerClosed {
		panic(err)
	}
}
