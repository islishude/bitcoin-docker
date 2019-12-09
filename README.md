Bitcoin Docker

```shell
docker pull islishude/bitcoin
mkdir bitcoin
cat > bitcoin/bitcoin.conf <<EOF
server=1
rpcuser=test
rpcpassword=test

txindex=1
rpcallowip=0.0.0.0/0
rpcport=8332
EOF

# if you are root at host
docker run -v ${PWD}/bitcoin:/root/.bitcoin -p 8332:8332 -p 8333:8333 islishude/bitcoin

# if you aren't root,uid is 1000 and gid also is 1000
docker run -v ${PWD}/bitcoin:/home/bitcoin/.bitcoin -p 8332:8332 -p 8333:8333 islishude/bitcoin
```
