FROM debian:stretch-slim

ARG VERSION=0.18.1
ARG ARCH=x86_64
ARG OS=linux-gnu

RUN groupadd -g 1000 bitcoin && useradd -m -g 1000 -u 1000 bitcoin
RUN apt-get update && apt-get install -qq --no-install-recommends -y dirmngr ca-certificates curl gpg && \
    curl -fsSLO "https://bitcoincore.org/bin/bitcoin-core-$VERSION/bitcoin-$VERSION-$ARCH-$OS.tar.gz" && \
    curl -fsSLO "https://bitcoincore.org/bin/bitcoin-core-$VERSION/SHA256SUMS.asc" && \
    gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys 01EA5486DE18A882D4C2684590C8019E36C2E964 && \
    gpg --verify SHA256SUMS.asc && \
    sha256sum -c --ignore-missing SHA256SUMS.asc && \
    tar zxf bitcoin-${VERSION}-${ARCH}-${OS}.tar.gz -C /usr/local --strip-components=1 --no-same-owner \
    --exclude=*-qt --exclude=*test_bitcoin --exclude=*-wallet --exclude=*-tx \
    --exclude=README.md  --exclude=*share* && \
    apt-get --purge remove dirmngr curl gpg -y && \
    rm *.tar.gz *.asc && rm -rf /root/.gnupg && rm -rf /var/lib/apt/lists/*
EXPOSE 8332 8833 18332 18333
VOLUME [ "/home/bitcoin" ]
HEALTHCHECK --interval=30s --timeout=30s --start-period=60s --retries=3 CMD [ "bitcoin-cli", "getbestblockhash" ]
USER bitcoin
ENTRYPOINT [ "/usr/local/bin/bitcoind" ]
