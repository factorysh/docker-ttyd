FROM bearstech/debian-dev:10 as dev

RUN set -eux \
    &&  apt-get update \
    &&  apt-get install -y --no-install-recommends \
            cmake \
            git \
            libjson-c-dev \
            libwebsockets-dev \
            upx \
    &&  apt-get clean \
    &&  rm -rf /var/lib/apt/lists/*

WORKDIR src
ARG TTYD_VERSION
RUN git clone --depth 1 https://github.com/tsl0922/ttyd.git\
        && cd ttyd \
        && git checkout $(TTYD_VERSION) \
        && mkdir p build \
        && cd build \
        && cmake .. \
        && make \
        && upx ttyd

FROM bearstech/debian:10

RUN set -eux \
    &&  apt-get update \
    &&  apt-get install -y --no-install-recommends \
            libjson-c3\
            libwebsockets8 \
            tmux \
    &&  apt-get clean \
    &&  rm -rf /var/lib/apt/lists/*

COPY --from=dev /src/ttyd/build/ttyd /usr/local/bin/
COPY start.sh /start.sh
EXPOSE 7681

CMD /start.sh
