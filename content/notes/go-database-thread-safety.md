+++
title = "Go SQL Database Thread Safety"
description = "It is safe by default to use sql.DB from multiple goroutines."
date = 2024-11-21
insert_anchor_links = "heading"

[extra]
keywords = ["go", "golang", "sql", "database", "connection", "mutex", "goroutine"]
+++

Making use of `sql.DB` from multiple goroutines is safe, since Go manages
its own internal mutex.[^1]

> DB is a database handle representing a pool of zero or more underlying connections.
> **It's safe for concurrent use by multiple goroutines.**[^2]

---

[^1]: <https://github.com/golang/go/blob/go1.23.3/src/database/sql/sql.go#L509>
[^2]: <https://pkg.go.dev/database/sql@go1.23.3#DB>
