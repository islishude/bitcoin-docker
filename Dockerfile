FROM ubuntu:16.04
WORKDIR /root
COPY . .
RUN apt update \
    && apt install --no-install-recommends -y openssl curl jq software-properties-common \
    && add-apt-repository ppa:bitcoin/bitcoin \
    && apt install bitcoind -y \
    && rm -rf /var/lib/apt/lists/*
EXPOSE 8332 8833 18332 18333
VOLUME [ "/root/.bitcoin" ]
ENTRYPOINT [ "bitcoind" ]
