#!/bin/bash

set -xe

go install github.com/abice/go-enum@latest
go install github.com/charmbracelet/glow@latest
go install github.com/charmbracelet/gum@latest
go install github.com/charmbracelet/soft-serve/cmd/soft@latest
go install github.com/charmbracelet/vhs@latest
go install github.com/cweill/gotests/gotests@latest
go install github.com/davidrjenni/reftools/cmd/fillstruct@latest
go install github.com/davidrjenni/reftools/cmd/fillswitch@latest
go install github.com/fatih/gomodifytags@latest
go install github.com/go-delve/delve/cmd/dlv@latest
go install github.com/go-task/task/v3/cmd/task@latest
go install github.com/godoctor/godoctor@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
go install github.com/haya14busa/goplay/cmd/goplay@latest
go install github.com/jesseduffield/lazygit@latest
go install github.com/josharian/impl@latest
go install github.com/koron/iferr@latest
go install github.com/kyoh86/richgo@latest
go install github.com/onsi/ginkgo/v2/ginkgo@latest
go install github.com/pressly/goose/v3/cmd/goose@latest
go install github.com/sclevine/yj@latest
go install github.com/segmentio/golines@latest
go install github.com/smartystreets/goconvey@latest
go install github.com/spf13/cobra-cli@latest
go install github.com/wagoodman/dive@latest
go install github.com/zricethezav/gitleaks@latest
go install golang.org/x/tools/cmd/godoc@latest
go install golang.org/x/tools/cmd/goimports@latest
go install golang.org/x/tools/cmd/gorename@latest
go install golang.org/x/tools/gopls@latest
go install golang.org/x/vuln/cmd/govulncheck@latest
go install gotest.tools/gotestsum@latest
go install mvdan.cc/gofumpt@latest
go install mvdan.cc/sh/v3/cmd/shfmt@latest

rustup component add clippy
rustup component add rust-analyzer
rustup component add rust-src
rustup component add rustfmt

cargo install --locked cargo-audit --features=fix
cargo install --locked cargo-edit
cargo install --locked cargo-outdated
cargo install --locked cargo-tarpaulin
cargo install --locked cargo-update
cargo install --locked drill
cargo install --locked flamegraph
cargo install --locked oha
cargo install --locked taplo-cli --features=lsp

npm install -g awk-language-server
npm install -g bash-language-server
npm install -g dockerfile-language-server-nodejs
npm install -g typescript-language-server typescript
npm install -g vscode-langservers-extracted
npm install -g yaml-language-server
