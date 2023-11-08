ARG DISTRO=bookworm

FROM rust:${DISTRO} as rust
FROM golang:${DISTRO} as go
FROM debian:${DISTRO}

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yq \
        ack \
        bash \
        ca-certificates \
        clang \
        cmake \
        curl \
        fd-find \
        fzf \
        g++ \
        gcc \
        git \
        gnupg \
        graphviz \
        gzip \
        jq \
        lld \
        lldb \
        luarocks \
        make \
        mandoc \
        miller \
        neofetch \
        nodejs \
        npm \
        openssh-client \
        openssl \
        pipenv \
        pkgconf \
        postgresql-client \
        python3 \
        python3-dev \
        python3-pip \
        ripgrep \
        shellcheck \
        sqlite3 \
        sudo \
        virtualenv \
        wget \
        yq \
        zsh

RUN ldconfig /usr/local/lib

RUN mkdir /cargo-target
RUN chmod 777 /cargo-target
ENV RUSTUP_HOME /usr/local/rustup
ENV CARGO_HOME /usr/local/cargo
ENV CARGO_TARGET_DIR /cargo-target
ENV RUST_LOG debug
ENV OTEL_EXPORTER_JAEGER_AGENT_HOST jaeger
ENV OTEL_EXPORTER_JAEGER_ENDPOINT http://jaeger:14268/api/traces
ENV GOPATH /go
ENV PATH /usr/local/cargo/bin:$GOPATH/bin:/usr/local/go/bin:$PATH

COPY --from=rust /usr/local/rustup /usr/local/rustup
COPY --from=rust /usr/local/cargo /usr/local/cargo
COPY --from=go /usr/local/go /usr/local/go

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" /usr/local/lib/node_modules && chmod -R 1777 "$GOPATH" /usr/local
RUN curl -s https://api.github.com/repos/helix-editor/helix/releases/latest | jq -r '.assets[] | select(.name | contains("x86_64.AppImage")) | select(.name | contains("zsync") | not) | .browser_download_url' | xargs curl -L --output /usr/local/bin/hx && chmod +x /usr/local/bin/hx

RUN useradd -m dev -s /bin/zsh
RUN mkdir /workspace && chown -R dev:dev /workspace
WORKDIR /workspace

COPY post-create.sh /post-create.sh

USER dev
RUN /post-create.sh

CMD ["zsh"]
