#!/bin/bash

#cible=192.168.12.3
cible=78.248.142.78

#
# Download the list of domains and the list of hostnames maintained by 
# https://github.com/notracking/hosts-blocklists
#
rm -rf domains.txt hostnames.txt
wget https://raw.githubusercontent.com/notracking/hosts-blocklists/master/hostnames.txt
wget https://raw.githubusercontent.com/notracking/hosts-blocklists/master/domains.txt


# Correct & Modify:
sed -i.bak -e "/::/d" domains.txt hostnames.txt
sed -i.bak -e "s/0.0.0.0/$cible/g" domains.txt hostnames.txt

# Whiteliste of some domains:
echo "To whitelist some domains.."
for domain in `cat whitelist` ; do sed -i "/$domain/d" *.txt ; done

# Add some domains
for domain in `cat myadd` ; do echo "address=/$domain/$cible" >> domains.txt ; done


#Mettre a jour le fichier hosts partagé par python:
#echo "Update du fichier partagé par python pour Adaway"
#pkill -f "SCREEN -d -m python3 -m http.server"
#cp /etc/dnsmasq_hostnames ~/macOS/adblock/share/hosts
#cd /home/trickyboy/macOS/adblock/share
#sed -i 's/192.168.12.3/127.0.0.1/g' hosts
#screen -d -m python3 -m http.server
