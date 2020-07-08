#!/bin/bash
while true; do \
    if [ "$(ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -q ${USER}@${HOST} exit ; echo $?)" = "0" ]; then \
        nohup ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -D 8888 -f -C -q -N ${USER}@${HOST} &>/dev/null &
        break
    else
        echo "${HOST} not available yet..."
    fi
done