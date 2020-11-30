#!/bin/bash

/usr/local/bin/ttyd -i 0.0.0.0 -R -c ${CREDENTIAL} tmux attach
