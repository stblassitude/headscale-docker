FROM docker.io/library/debian:12-slim
ARG VERSION=v0.22.3

RUN apt update && apt install -y wget

RUN wget -O headscale.deb https://github.com/juanfont/headscale/releases/download/${VERSION}/headscale_${VERSION##v}_linux_$(dpkg --print-architecture).deb \
    && apt install ./headscale.deb
RUN mkdir -p /var/run/headscale \
    && chown 1000:1000 /var/run/headscale

ENTRYPOINT ["/usr/bin/headscale"]
