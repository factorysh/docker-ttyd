#!/bin/bash

docker run \
    --rm \
    -ti \
    -u `id -u` \
    --volumes-from=ttyd-agent \
    -v $1:/the_key \
    ttyd-agent ssh-add -t 1h /the_key
