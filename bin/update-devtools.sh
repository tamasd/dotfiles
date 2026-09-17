#!/bin/sh

set -x

rustup self update
rustup update

$HOME/dotfiles/bin/update-helix.sh
$HOME/dotfiles/bin/update-odin.sh
$HOME/dotfiles/bin/update-ols.sh
$HOME/dotfiles/bin/update-go.sh
$HOME/dotfiles/bin/update-zig.sh
$HOME/dotfiles/bin/update-zls.sh
$HOME/dotfiles/bin/update-glsl-analyzer.sh
$HOME/dotfiles/bin/update-erlang.sh
$HOME/dotfiles/bin/update-rebar3.sh
$HOME/dotfiles/bin/update-erlang-ls.sh
$HOME/dotfiles/bin/update-elp.sh
$HOME/dotfiles/bin/update-fossil.sh

go install github.com/bcicen/ctop@master
go install github.com/derailed/k9s@latest
go install github.com/go-delve/delve/cmd/dlv@latest
go install github.com/go-task/task/v3/cmd/task@latest
go install github.com/golangci/golangci-lint/v2/cmd/golangci-lint@latest
go install github.com/jesseduffield/lazygit@latest
go install github.com/k3d-io/k3d/v5@latest
go install github.com/nametake/golangci-lint-langserver@latest
go install github.com/wagoodman/dive@latest
go install golang.org/x/tools/cmd/godoc@latest
go install golang.org/x/tools/cmd/goimports@latest
go install golang.org/x/tools/cmd/gorename@latest
go install golang.org/x/tools/gopls@latest

rustup component add clippy
rustup component add rust-analyzer
rustup component add rust-src
rustup component add rustfmt

cargo install --locked drill
cargo install --locked tree-sitter-cli
