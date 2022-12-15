#!/bin/bash

go install github.com/cweill/gotests/gotests@latest
go install github.com/davidrjenni/reftools/cmd/fillstruct@latest
go install github.com/fatih/gomodifytags@latest
go install github.com/go-delve/delve/cmd/dlv@latest
go install github.com/go-task/task/v3/cmd/task@latest
go install github.com/godoctor/godoctor@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
go install github.com/haya14busa/goplay/cmd/goplay@latest
go install github.com/josharian/impl@latest
go install golang.org/x/tools/cmd/goimports@latest
go install golang.org/x/tools/gopls@latest
go install mvdan.cc/sh/v3/cmd/shfmt@latest

rustup component add clippy
rustup component add rust-analyzer
rustup component add rust-src
rustup component add rustfmt

cargo install cargo-audit --features=fix
cargo install cargo-check
cargo install cargo-edit
cargo install cargo-nextest
cargo install cargo-tarpaulin
cargo install cargo-udeps
cargo install drill
cargo install oha
