# qbdiff/qbpatch docker images

Docker images of [qbdiff](https://github.com/kspalaiologos/qbdiff), the "improved and modernised version of [bsdiff](https://www.daemonology.net/bsdiff/)".

The images can be found at my [qbdiff repo](https://hub.docker.com/repository/docker/akorda1/qbdiff/general) at docker hub.

## Running the image

Run `qbdiff` using:

```powershell
docker run --rm -v ${PWD}:/data akorda1/qbdiff /data/Dockerfile /data/README.md /data/diff.patch
```

Run `qbpatch` using:

```powershell
docker run --rm -it -v ${PWD}:/data --entrypoint bash akorda1/qbdiff /app/qbpatch /data/Dockerfile /data/README2.md /data/diff.patch
```

## Building the image

Build the image using:

```powershell
docker build --tag qbdiff .
```
