# syntax=docker/dockerfile:1
FROM ubuntu:24.04 AS base

LABEL org.opencontainers.image.title="shell-utils-dev" \
  org.opencontainers.image.description="Dev image of shell-utils" \
  org.opencontainers.image.authors="@logisparte" \
  org.opencontainers.image.source="https://github.com/logisparte/shell-utils" \
  org.opencontainers.image.licenses="Apache-2.0"

RUN <<EOF
  DEBIAN_FRONTEND=noninteractive \
    apt-get update && apt-get install --yes --quiet --no-install-recommends \
      apt-transport-https \
      bash \
      ca-certificates \
      curl \
      git \
      gnupg2 \
      software-properties-common \
      ssh-client \
      sudo \
      vim \
      wget \
      zsh
  apt-get clean
  rm -rf /var/lib/apt/lists/*
EOF

ENV EDITOR="/usr/bin/vim"

FROM base AS project

RUN <<EOF
  curl --silent --fail --show-error --location https://deb.nodesource.com/setup_lts.x \
    | bash -
  DEBIAN_FRONTEND=noninteractive \
    apt-get update && apt-get install --yes --quiet --no-install-recommends \
      nodejs \
      shellcheck \
      shfmt
  npm config --location=global set update-notifier=false fund=false
  npm install --location=global --omit=dev --omit=optional \
    markdownlint-cli \
    prettier \
    @commitlint/cli
  npm cache clean --force
  apt-get clean
  rm -rf /var/lib/apt/lists/*
EOF

FROM project AS kcov_builder

RUN <<EOF
  KCOV_VERSION="42"
  KCOV_DIRECTORY="kcov-$KCOV_VERSION"
  KCOV_BUILD_DIRECTORY="$KCOV_DIRECTORY/build"
  DEBIAN_FRONTEND=noninteractive \
    apt-get update && apt-get install --yes --quiet --no-install-recommends \
      binutils-dev \
      build-essential \
      cmake \
      libcurl4-openssl-dev \
      libdw-dev \
      libiberty-dev \
      libssl-dev \
      zlib1g-dev
  curl --silent --show-error --location \
    "https://github.com/SimonKagstrom/kcov/archive/refs/tags/v$KCOV_VERSION.tar.gz" \
      | tar --extract --gzip
  cmake -B "$KCOV_BUILD_DIRECTORY" -Wno-dev "$KCOV_DIRECTORY"
  cmake --build "$KCOV_BUILD_DIRECTORY" --target install
  apt-get clean
  rm -rf /var/lib/apt/lists/*
EOF

FROM project AS project_shellspec_kcov

COPY --from=kcov_builder /usr/local/bin/kcov* /usr/bin/

RUN <<EOF
  curl --silent --show-error --location https://git.io/shellspec \
    | sh -s 0.28.1 --dir /opt/shellspec --bin /usr/bin --yes
  DEBIAN_FRONTEND=noninteractive \
    apt-get update && apt-get install --yes --quiet --no-install-recommends \
      binutils \
      libcurl4 \
      libdw1 \
      zlib1g
  apt-get clean
  rm -rf /var/lib/apt/lists/*
EOF
