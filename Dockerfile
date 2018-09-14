FROM alpine:latest
LABEL maintainer="imTHAI <imTHAI@leet.la>"
LABEL description="dnsmasq + adblock list under Alpine"

RUN 	apk --update upgrade \
	&& apk add --no-cache dnsmasq tzdata \
	&& mkdir /adblock
	&& touch /adblock/domains.txt /adblock/hostnames.txt

COPY files/dnsmasq.conf /etc/dnsmasq.conf
COPY files/dnsmasq_resolv.conf /etc/dnsmasq_resolv.conf

VOLUME /adblock

EXPOSE 53/tcp 53/udp

ENTRYPOINT ["dnsmasq", "-k", "-u", "root","--log-facility=-"]
