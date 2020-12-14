#!/bin/bash

docker run \
    --rm \
    -ti \
    -u `id -u` \
    --volumes-from=ttyd-agent \
    ttyd-agent ssh-add -D
