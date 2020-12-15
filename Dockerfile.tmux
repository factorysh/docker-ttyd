FROM bearstech/debian:10

RUN set -eux \
    &&  apt-get update \
    &&  apt-get install -y --no-install-recommends \
            htop \
            openssh-client \
            tmux \
            tree \
            vim \
            vitetris \
    &&  apt-get clean \
    &&  rm -rf /var/lib/apt/lists/*

ARG UID
RUN useradd -m user --uid "${UID}" --shell /bin/bash

ENV SHELL=/bin/bash
USER user

CMD ["tmux"]
