# docker-dnsmasq-adblock

Run

On mac:

``docker run -d --name dns-adblock --cap-add=NET_ADMIN -p 53:53/udp -e TZ=`ls -la /etc/localtime | cut -d/ -f8-9` work:latest``

`docker run -d --dns-adblock test --cap-add=NET_ADMIN -p 53:53/udp -v /etc/localtime:/etc/localtime dnsmasq-adblock:latest`
