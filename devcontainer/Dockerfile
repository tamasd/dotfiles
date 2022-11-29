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

COPY post-create.sh /post-create.sh
