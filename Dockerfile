FROM alpine:3.4 
MAINTAINER Alexandr Ivanov ivanov.ua@ukr.net
RUN echo "http://dl-4.alpinelinux.org/alpine/edge/community/" >> /etc/apk/repositories && \
    echo "http://dl-4.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories
RUN apk update && apk add openvpn openvpn-dev autoconf re2c libtool \
	openldap-dev openssl-dev gcc-objc make git openssl easy-rsa iptables bash
RUN git clone https://github.com/snowrider311/openvpn-auth-ldap 
RUN	cd /openvpn-auth-ldap && \
        ./regen.sh && \
        ./configure --with-openvpn=/usr/include/openvpn CFLAGS="-fPIC" OBJCFLAGS="-std=gnu11" && \
        make && make install
RUN rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/* /openvpn-auth-ldap
RUN mkdir -p /dev/net && \
	mknod /dev/net/tun c 10 200
