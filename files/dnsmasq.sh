#!/bin/sh -e

# pipe stderr to stdout and run app via uwsgi
exec 2>&1
exec dnsmasq -k
