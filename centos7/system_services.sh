#!/bin/bash
set -e
source /bd_build/buildconfig
set -x

## Install init process.
mkdir -p /sbin
cp /bd_build/bin/my_init /sbin/
mkdir -p /etc/my_init.d
mkdir -p /etc/container_environment
touch /etc/container_environment.sh
touch /etc/container_environment.json
chmod 700 /etc/container_environment

groupadd -g 8377 docker_env
chown :docker_env /etc/container_environment.sh /etc/container_environment.json
chmod 640 /etc/container_environment.sh /etc/container_environment.json
ln -s /etc/container_environment.sh /etc/profile.d/

## Install runit.
$minimal_yum_install /bd_build/runit-2.1.2-1.el7.centos.x86_64.rpm

## Install a syslog daemon and logrotate.
[ "$DISABLE_SYSLOG" -eq 0 ] && /bd_build/services/syslog-ng/syslog-ng.sh || true

## Install the SSH server.
[ "$DISABLE_SSH" -eq 0 ] && /bd_build/services/sshd/sshd.sh || true

## Install cron daemon.
[ "$DISABLE_CRON" -eq 0 ] && /bd_build/services/cron/cron.sh || true
