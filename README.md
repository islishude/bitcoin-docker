Bitcoin Docker


```shell
docker pull islishude/bitcoin:v0.18.1
mkdir -p chaindata/.bitcoin
docker run -v ${PWD}/blockchain:/home/bitcoin -p 8332:8332 -p 8833:8333 islishude/bitcoin:v0.18.1
```
