#!/bin/bash
set -e
if [[ ! -e /etc/service/sshd/down && ! -e /etc/ssh/ssh_host_rsa_key ]] || [[ "$1" == "-f" ]]; then
	echo "No SSH host key available. Generating one..."
	export LC_ALL=C
	ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N "" -C ""
	ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -N "" -C ""
fi
