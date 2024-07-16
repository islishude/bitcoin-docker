Bitcoin Docker

```shell
mkdir -p -m 0777 chaindata

cat > chaindata/bitcoin.conf <<EOF
chain=regtest
txindex=1
discover=0

[regtest]
server=1
rpcbind=0.0.0.0
rpcallowip=0.0.0.0/0
rpcport=8332
rpcuser=test
rpcpassword=test
EOF

docker run -v ./chaindata:/root/.bitcoin -p 8332:8332 ghcr.io/islishude/bitcoin
```
