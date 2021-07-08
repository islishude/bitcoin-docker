FROM debian:buster-slim as downloader
ARG VERSION=0.21.1
ARG ARCH=x86_64
ARG OS=linux-gnu
RUN apt-get update && apt-get install -qq --no-install-recommends -y dirmngr ca-certificates curl gpg gpg-agent
RUN curl -fsSLO --proto '=https' --tlsv1.2 "https://bitcoincore.org/bin/bitcoin-core-$VERSION/bitcoin-$VERSION-$ARCH-$OS.tar.gz"
RUN curl -fsSLO --proto '=https' --tlsv1.2 "https://bitcoincore.org/bin/bitcoin-core-$VERSION/SHA256SUMS.asc"
RUN gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys 01EA5486DE18A882D4C2684590C8019E36C2E964 
RUN gpg --verify SHA256SUMS.asc
RUN sha256sum -c --ignore-missing SHA256SUMS.asc
RUN tar zxf bitcoin-${VERSION}-${ARCH}-${OS}.tar.gz -C /usr/local --strip-components=1 --no-same-owner
RUN /usr/local/bin/bitcoind -version

FROM debian:buster-slim
RUN groupadd -g 1000 bitcoin && useradd -m -g 1000 -u 1000 bitcoin
COPY --from=downloader /usr/local/bin/bitcoind /usr/local/bin/
EXPOSE 8332 8333
ENTRYPOINT [ "bitcoind" ]
