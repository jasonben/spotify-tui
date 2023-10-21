FROM rust:bullseye AS builder
RUN \
  apt update && \
  apt-get install \
  --no-install-recommends -y -qq \
  pkg-config \
  libssl-dev \
  libxcb1-dev \
  libxcb-render0-dev \
  libxcb-shape0-dev \
  libxcb-xfixes0-dev \
  ca-certificates \
  wget

RUN \
  cargo install spotify-tui

FROM debian:bullseye-slim
RUN \
  apt update && \
  apt-get install \
  --no-install-recommends -y -qq \
  bash \
  ca-certificates \
  curl

COPY --from=builder /usr/local/cargo/bin/spt /usr/local/bin/spt
ENTRYPOINT ["/usr/local/bin/spt"]
