FROM bearstech/debian:10

RUN set -eux \
    &&  apt-get update \
    &&  apt-get install -y --no-install-recommends \
            tmux \
    &&  apt-get clean \
    &&  rm -rf /var/lib/apt/lists/*

CMD tmux
