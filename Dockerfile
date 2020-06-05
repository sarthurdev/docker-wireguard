FROM alpine:3.12

ARG S6_OVERLAY_RELEASE=https://github.com/just-containers/s6-overlay/releases/latest/download/s6-overlay-amd64.tar.gz
ENV S6_OVERLAY_RELEASE=${S6_OVERLAY_RELEASE}

ADD ${S6_OVERLAY_RELEASE} /tmp/s6overlay.tar.gz

RUN apk upgrade --update --no-cache \
    && rm -rf /var/cache/apk/* \
    && tar xzf /tmp/s6overlay.tar.gz -C / \
    && rm /tmp/s6overlay.tar.gz

RUN \
    apk add --no-cache \
        bash \
	    bc \
        curl \
        gnupg \ 
        ifupdown \
        iproute2 \
        iptables \
        perl \
        libqrencode

RUN \
    adduser --system --uid 911 --home /config --shell /bin/false abc && \
    addgroup abc && \
    addgroup abc users

COPY /root /

EXPOSE 51820/udp

ENTRYPOINT [ "/init" ]
