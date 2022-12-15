ARG DISTRO=bullseye

FROM debian:${DISTRO}

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yq \
        ack \
        bash \
        ca-certificates \
        clang \
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
        zsh

RUN pip install yq

RUN ldconfig /usr/local/lib

RUN mkdir /cargo-target
RUN chmod 777 /cargo-target
ENV CARGO_TARGET_DIR /cargo-target
ENV RUST_LOG debug
ENV OTEL_EXPORTER_JAEGER_AGENT_HOST jaeger
ENV OTEL_EXPORTER_JAEGER_ENDPOINT http://jaeger:14268/api/traces

COPY post-create.sh /post-create.sh
