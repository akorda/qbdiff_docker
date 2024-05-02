FROM amd64/debian:bookworm-slim AS build

RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates \
    autoconf \
    automake \
    build-essential \
    git \
    liblzma-dev \
    libomp-dev \
    libtool \
    m4 \
    make \
    pkg-config \
    tar \
    wget \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
RUN wget -q https://github.com/kspalaiologos/qbdiff/archive/refs/tags/1.0.0.tar.gz \
    && tar xvfz 1.0.0.tar.gz

WORKDIR /app/qbdiff-1.0.0
RUN echo '1.0.0' > .tarball-version \
    && chmod +x ./bootstrap.sh \
    && ./bootstrap.sh \
    && ./configure \
    && make \
    && make install

FROM amd64/debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends libgomp1=12.* \
    && rm -rf /var/lib/apt/lists/*

COPY --from=build /app/qbdiff-1.0.0/qbdiff /app/qbdiff
COPY --from=build /app/qbdiff-1.0.0/qbpatch /app/qbpatch
COPY --from=build /app/qbdiff-1.0.0/.libs /app/.libs
COPY --from=build /usr/local/lib/libqbdiff.so /usr/local/lib/libqbdiff.so

RUN ldconfig

WORKDIR /app

ENTRYPOINT ["./qbdiff"]
