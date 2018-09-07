FROM alpine:latest
LABEL maintainer="imTHAI <imTHAI@leet.la>"
LABEL description="Alpine compiling latest version of pixelsrv-tls."

ENV tinyserver pixelserv-tls

RUN 	apk update && \
	apk upgrade && \
	apk add git autoconf build-base openssl openssl-dev automake linux-headers

RUN 	cd /tmp && \
	git clone https://github.com/kvic-z/${tinyserver}.git && \
	cd ${tinyserver} && \
	autoreconf -i && \
	./configure && \
	 make
