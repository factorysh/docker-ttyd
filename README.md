Docker TTYd
===========

[ttyd](https://github.com/tsl0922/ttyd) exposes a TTY on a webpage, with a websocket.

Lets add tmux for multiple viewer and splitted terms.

## Build

    make images

## Demo

1) Start *ssh-agent*
2) Open a tmux
3) Run *ttyd* with `tmux attach`
4) reattach the tmux

```
make images
make run CREDENTIAL=beuha:aussi
```

You are in a tmux, open http://localhost:7681/ with credentials.

```

+------+            +-------------+
| tmux +------------+ socket tmux |
+------+            +------+------+
                           |
+-----------------+        |
| ttyd            |        |
| +-------------+ |        |
| | tmux attach +-+--------+
| +-------------+ | ws
|                 +----------------------> browser
+-----------------+

```

You can add keys to the jailed *ssh-agent*, available in the tmux session
```
./ssh-add.sh ~/.ssh/id_rsa
```
