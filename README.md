Docker TTYd
===========

[ttyd](https://github.com/tsl0922/ttyd) expose a TTY on a webpage, with a websocket.

Lets add tmux for multiple viewer and splitted terms.

## Build

    make image-ttyd

## Demo

1) Open a tmux
2) Run *ttyd* with `tmux attach`
3) reattach the tmux

    make images
    make run

You are in a tmux, open http://localhost:7681/ with credentials hidden in Makefile.
