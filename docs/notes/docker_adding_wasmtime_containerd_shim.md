# Docker - Adding Wasmtime (Containerd Shim)

/etc/docker/daemon.json

```json
{
  "features": {
    "containerd-snapshotter": true
  }
}
```

```shell
docker build --output . - <<EOF
FROM rust:latest as build
RUN cargo install \
    --git https://github.com/containerd/runwasi.git \
    --bin containerd-shim-wasmtime-v1 \
    --root /out \
    containerd-shim-wasmtime
FROM scratch
COPY --from=build /out/bin /
EOF
```

Put binary in PATH

```shell
mv ./containerd-shim-wasmtime-v1 /usr/local/bin
```
