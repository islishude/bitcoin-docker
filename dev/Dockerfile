FROM ubuntu:16.04
WORKDIR /root
RUN apt update \
    && apt install --no-install-recommends -y ca-certificates openssl tar curl \
    && curl -fsSL --compressed http://bitcoincore.org/bin/bitcoin-core-0.16.3/bitcoin-0.16.3-x86_64-linux-gnu.tar.gz -o bitcoin.tar.gz \
    && tar zxvf bitcoin.tar.gz --strip-components 1 -C /usr/local \
    && rm -rf bitcoin.tar.gz \
    && apt remove --purge -y tar curl \
    && apt autoclean \
    && apt autoremove \
    && rm -rf /var/lib/apt/lists/*
EXPOSE 8332 8833 18332 18333
VOLUME [ "/root/.bitcoin" ]
ENTRYPOINT [ "/usr/local/bin/bitcoind" ]
