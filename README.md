# docker-dnsmasq-adblock


There are 2 lists.
`/adblock/hostnames.txt which is a list of hostnames to blacklist`
`/adblock/domains.txt which is a list of domains to blacklist`

The dns server will read them to redirect all the domains and hostnames to a fake ip.
`conf-file=/adblock/domains.txt`
`addn-hosts=/adblock/hostnames.txt`

Those files are empties in the image. 

Personally I use the list from https://github.com/notracking/hosts-blocklists
This list is daily updated and pretty complete.
What I suggest:
1. Create a dedicated folder on the host ( i.e. ~/adblock )
2. Download the 2 lists from the notracking's repository
`cd ~/adblock`
`wget https://raw.githubusercontent.com/notracking/hosts-blocklists/master/hostnames.txt`
`wget https://raw.githubusercontent.com/notracking/hosts-blocklists/master/domains.txt`
3. Run the container: `docker run -d --dns-adblock test --cap-add=NET_ADMIN -p 53:53/udp -v ~/adblock:/adblock -v /etc/localtime:/etc/localtime docker trickyboy/dnsmasq-adblock`
4. It would be nice to schedule a daily download of the 2 files to be up-to-date with the adblock lists.
5. Also I combine this dns-adblock with a pixelserv-tls server ( see my other repo on docker hub). 


# Infos:
* I created a simple bash script that download the lists, modify them to redirect to a specific ip, and use my whitelist and my own blacklist. See update_dnsmasq_adblock.sh in the GitHub repository.
* To see logs: `docker container logs -f dns-adblock `
* To run the docker on MacOS:
``docker run -d --name dns-adblock --cap-add=NET_ADMIN -p 53:53/udp -v ~/adblock:/adblock -e TZ=`ls -la /etc/localtime | cut -d/ -f8-9` trickyboy/dnsmasq-adblock``
