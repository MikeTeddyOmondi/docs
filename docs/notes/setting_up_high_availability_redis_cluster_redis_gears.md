# Setting Up HA Redis Cluster (Redis Gears)

With Docker:

```shell
docker run -d --name rgcluster -p 30001:30001 -p 30002:30002 -p 30003:30003 redislabs/rgcluster:latest
```

## Requirements:

- `gears-cli` utility tool

```shell
pip install gears-cli
```

- `rgsync` Python package

```shell
pip install rqsync
```
