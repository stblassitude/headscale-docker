FROM docker.io/library/debian:12-slim AS builder

RUN apt update && apt install -y wget
#RUN wget -O headscale.deb https://github.com/juanfont/headscale/releases/download/v0.22.3/headscale_0.22.3_linux_$(dpkg --print-architecture).deb \
#    && apt install ./headscale.deb \
#    && rm -f headscale.deb

RUN wget -O headscale https://github.com/juanfont/headscale/releases/download/v0.22.3/headscale_0.22.3_linux_$(dpkg --print-architecture) \
    && chmod 555 headscale

FROM scratch

COPY --from=builder headscale /headscale

ENTRYPOINT ["/headscale"]
