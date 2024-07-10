Bitcoin Docker

```shell
docker pull ghcr.io/islishude/bitcoin
mkdir -p -m 0777 chaindata/bitcoin
cat > chaindata/bitcoin/bitcoin.conf <<EOF
server=1
rpcuser=test
rpcpassword=test

rpcallowip=0.0.0.0/0
rpcbindip=0.0.0.0:8332
EOF

docker run -v ${PWD}/bitcoin:/bitcoin -p 8332:8332 ghcr.io/islishude/bitcoin -datadir=/bitcoin
```
