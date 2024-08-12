FROM docker.io/library/debian:12-slim AS builder
ARG VERSION=v0.22.3

RUN apt update && apt install -y wget

RUN wget -O headscale https://github.com/juanfont/headscale/releases/download/${VERSION}/headscale_${VERSION##v}_linux_$(dpkg --print-architecture) \
    && chmod 555 headscale
RUN mkdir -p /var/run/headscale \
    && touch /var/run/headscale/.keep
    && chown 1000:1000 /var/run/headscale

FROM scratch

COPY --from=builder headscale /headscale
COPY --from=builder /var/run/headscale/ /var/run/headscale/

USER 1000

ENTRYPOINT ["/headscale"]
