#!/bin/sh -e

exec 2>&1
cd /etc/dnsmasq.d
git fetch --all
git reset --hard origin/master

exit 0
