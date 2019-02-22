FROM ubuntu:16.04
WORKDIR /root
ENV VERSION 0.17.1-xenial1
RUN apt update \
    && apt install --no-install-recommends -y openssl software-properties-common \
    && add-apt-repository -y ppa:bitcoin/bitcoin \
    && apt install -y bitcoind=${VERSION} \
    && apt autoclean \
    && apt autoremove \
    && rm -rf /var/lib/apt/lists/*
EXPOSE 8332 8833 18332 18333
VOLUME [ "/root/.bitcoin" ]
ENTRYPOINT [ "/usr/local/bin/bitcoind" ]
