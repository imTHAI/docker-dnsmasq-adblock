#!/bin/bash

# If you have a pixelserv server u want to redirect the ads to, define the ip of the server:
# Default is 0.0.0.0
cible=0.0.0.0

#
# Download the list of domains and the list of hostnames maintained by 
# https://github.com/notracking/hosts-blocklists
#
echo "Applying some corrections to the lists..."
rm -rf domains.txt hostnames.txt
wget https://raw.githubusercontent.com/notracking/hosts-blocklists/master/hostnames.txt
wget https://raw.githubusercontent.com/notracking/hosts-blocklists/master/domains.txt

# For security, if downloads failed:
touch domains.txt hostnames.txt

# Correct & Modify in case you don't use the files as they are::
if [[ $cible != "0.0.0.0" ]]
then
        sed -i.bak -e "/::/d" domains.txt hostnames.txt
        sed -i.bak -e "s/0.0.0.0/$cible/g" domains.txt hostnames.txt
fi

# Whitelist of some domains:
for host in `cat whitelist`
do
domain=$(echo $host | sed "s/.*\.\(.*\..*\)$/\1/")
sed -i.bak "/$domain/d" *.txt
done

# Add my own blacklist:
for domain in `cat myadd` ; do echo "address=/$domain/$cible" >> domains.txt ; done

# Restart the docker
echo "Restarting the adblocking dns server..."
docker container restart dns-adblock

