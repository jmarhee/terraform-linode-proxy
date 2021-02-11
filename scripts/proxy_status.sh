#!/bin/bash

connect_loop () {
	ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -q ${USER}@${HOST} "while true; do sleep 30; done" ; networksetup -setsocksfirewallproxy wi-fi 127.0.0.1 8888
}

if [ ! -f nohup.out ]; then touch nohup.out; fi
networksetup -setsocksfirewallproxy wi-fi 127.0.0.1 8888
export -f connect_loop
nohup USER=${USER} HOST=${HOST} connect_loop &>/dev/null &
