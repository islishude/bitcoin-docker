FROM buildpack-deps:jessie
WORKDIR /root
COPY .bitcoin .
RUN wget -c https://bitcoincore.org/bin/bitcoin-core-0.16.3/bitcoin-0.16.3-x86_64-linux-gnu.tar.gz -O bitcoin.tar.gz && \
    tar -xvf bitcoin.tar.gz --strip-components=1 -C /usr/local --no-same-owner && \
    rm -rf /root/bitcoin.tar.gz
EXPOSE 8332 8833
VOLUME [ "/root/.bitcoin" ]
CMD [ "bitcoind" ]
