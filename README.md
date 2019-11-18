Bitcoin Docker

```shell
docker pull islishude/bitcoin
mkdir -p blockchain/.bitcoin
cat > blockchain/.bitcoin/bitcoin.conf <<EOF
server=1
rpcuser=test
rpcpassword=test

txindex=1
rpcallowip=0.0.0.0/0
rpcport=8332
EOF
docker run -v ${PWD}/blockchain:/home/bitcoin -p 8332:8332 -p 8333:8333 islishude/bitcoin
```
