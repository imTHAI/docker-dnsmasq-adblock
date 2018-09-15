#!/bin/bash

cible=192.168.0.1

#
# Download the list of domains and the list of hostnames maintained by 
# https://github.com/notracking/hosts-blocklists
#
rm -rf domains.txt hostnames.txt
wget https://raw.githubusercontent.com/notracking/hosts-blocklists/master/hostnames.txt
wget https://raw.githubusercontent.com/notracking/hosts-blocklists/master/domains.txt


# Correct & Modify ( syntax for compatibility with GNU and Mac sed):
sed -i.bak -e "/::/d" domains.txt hostnames.txt
sed -i.bak -e "s/0.0.0.0/$cible/g" domains.txt hostnames.txt

# Whitelist of some domains:
echo "To whitelist some domains.."
for domain in `cat whitelist` ; do sed -i.bak "/$domain/d" *.txt ; done

# Add some domains
for domain in `cat myadd` ; do echo "address=/$domain/$cible" >> domains.txt ; done

