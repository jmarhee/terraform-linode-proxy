#!/bin/bash

proxy_status () {

	while true; do \
	    if [ "$(ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -q ${USER}@${HOST} exit ; echo $?)" = "0" ]; then \
	    	sleep 5; continue
	    else
	        networksetup -setsocksfirewallproxystate wi-fi off
	        break
	    fi
	done

}

networksetup -setsocksfirewallproxy wi-fi 127.0.0.1 8888
export -f proxy_status
nohup USER=${USER} HOST=${HOST} proxy_status &>/dev/null &