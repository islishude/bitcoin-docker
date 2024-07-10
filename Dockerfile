# syntax=docker/dockerfile:1
FROM --platform=$BUILDPLATFORM debian:bookworm AS downloader
ARG DISTVER=27.1
RUN apt-get update && apt-get install -qq --no-install-recommends -y dirmngr ca-certificates curl gpg gpg-agent git
WORKDIR /download
RUN curl -fsSLO --proto '=https' --tlsv1.2 "https://bitcoincore.org/bin/bitcoin-core-$DISTVER/bitcoin-$DISTVER-x86_64-linux-gnu.tar.gz"
RUN curl -fsSLO --proto '=https' --tlsv1.2 "https://bitcoincore.org/bin/bitcoin-core-$DISTVER/bitcoin-$DISTVER-aarch64-linux-gnu.tar.gz"
RUN curl -fsSLO --proto '=https' --tlsv1.2 "https://bitcoincore.org/bin/bitcoin-core-$DISTVER/SHA256SUMS"
RUN curl -fsSLO --proto '=https' --tlsv1.2 "https://bitcoincore.org/bin/bitcoin-core-$DISTVER/SHA256SUMS.asc"
RUN sha256sum --ignore-missing --check SHA256SUMS
RUN git clone --depth=1 https://github.com/bitcoin-core/guix.sigs
RUN gpg --import guix.sigs/builder-keys/*
RUN gpg --verify SHA256SUMS.asc
RUN mkdir -p amd64 && tar zxf bitcoin-$DISTVER-x86_64-linux-gnu.tar.gz -C amd64 --strip-components=1 --no-same-owner && \
    mkdir -p arm64 && tar zxf bitcoin-$DISTVER-aarch64-linux-gnu.tar.gz -C arm64 --strip-components=1 --no-same-owner

FROM --platform=$TARGETPLATFORM debian:bookworm-slim
ARG TARGETARCH
RUN groupadd -g 1000 bitcoin && useradd -m -g 1000 -u 1000 bitcoin
COPY --from=downloader /download/${TARGETARCH}/bin/bitcoind /download/${TARGETARCH}/bin/bitcoin-cli /usr/local/bin/
COPY --from=downloader /download/${TARGETARCH}/bitcoin.conf /
EXPOSE 8332 8333
ENTRYPOINT [ "bitcoind" ]
