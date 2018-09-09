FROM alpine:latest
LABEL maintainer="imTHAI <imTHAI@leet.la>"
LABEL description="dnsmasq + adblock list under Alpine"

COPY script/boot.sh /sbin/boot.sh
COPY script/list_update.sh /sbin/list_update.sh
RUN 	apk --update upgrade &&\
	apk add --no-cache bash runit dnsmasq git tzdata &&\
	git clone https://github.com/notracking/hosts-blocklists.git /etc/dnsmasq.d &&\
	cd /etc/dnsmasq.d &&\
	sed -i -e '/::/d' -e "s/0.0.0.0/127.0.0.1/g" domains.txt hostnames.txt &&\
	# Cleaning:
	rm -rf /var/cache/apk/* &&\
	chmod +x /sbin/boot.sh &&\
	chmod +x /sbin/list_update.sh &&\
	mkdir /etc/run_once &&\
	mkdir /etc/service/dns &&\
	mkdir /etc/service/crond

COPY script/dnsmasq.conf /etc/dnsmasq.conf
COPY script/dnsmasq_resolv.conf /etc/dnsmasq_resolv.conf
COPY script/dnsmasq.sh /etc/service/dns/run
COPY script/crond.sh /etc/service/crond/run
COPY script/root /var/spool/cron/crontabs/root

EXPOSE 53/tcp 53/udp

CMD [ "/sbin/boot.sh" ]
