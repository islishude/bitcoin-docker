FROM buildpack-deps:stretch
ENV VERSION=0.16.3 PLATFORM=x86_64-linux-gnu
WORKDIR /root
COPY . .
RUN wget wget https://bitcoincore.org/bin/bitcoin-core-${VERSION}/bitcoin-${VERSION}-${PLATFORM}.tar.gz && \
    # gpg --decrypt SHA256SUMS.asc && \
    # openssl dgst -sha256 bitcoin-${VERSION}-${PLATFORM}}.tar.gz && \
    tar -xvf bitcoin-${VERSION}-${PLATFORM}.tar.gz --strip-components=1 -C /usr/local --no-same-owner && \
    rm -rf bitcoin-${VERSION}-${PLATFORM}}.tar.gz
EXPOSE 8332 8833 18332 18333
VOLUME [ "/root/.bitcoin" ]
ENTRYPOINT [ "bitcoind" ]
