+++
title = "Enabling HTTPS in a Go Application"
description = "Adding HTTPS/TLS with the certmagic module."
date = 2024-11-21
insert_anchor_links = "heading"

[extra]
keywords = ["go", "golang", "https", "tls", "ssl", "certmagic", "caddy"]
code = true
+++

If you don't want to use a reverse proxy like Caddy or Nginx, you can add
HTTPS support directly to your Go application, using the module `certmagic`, developed by
the people behind the Caddy server project.[^1]

### Setup
Install the `certmagic` module: `go get github.com/caddyserver/certmagic`

Write your code:
```go
package main

import (
	"flag"
	"net/http"

	"github.com/caddyserver/certmagic"
)

func main() {
	production := flag.Bool("production", false, "run in production mode (https)")
	flag.Parse()

	http.HandleFunc("/", func(res http.ResponseWriter, req *http.Request) {
		res.Write([]byte("Hello World!"))
	})

	if *production {
		println("Running webserver in production")
		certmagic.DefaultACME.Email = "email@website.com" // optional but recommended
		certmagic.HTTPS([]string{"website.com"}, http.DefaultServeMux)
	} else {
		println("Running webserver on http://localhost:8080")
		http.ListenAndServe("localhost:8080", http.DefaultServeMux)
	}
}
```

To run the HTTP server with TLS/HTTPS enabled:  
`go run main.go -production`

---

**Note:** Unless you have it set up by other means, `certmagic` does not support HTTPS on `localhost`.  
**Note:** Multiple Go applications running on the same port will panic. In this case use a reverse-proxy.

---

[^1]: <https://github.com/caddyserver/certmagic#readme>
