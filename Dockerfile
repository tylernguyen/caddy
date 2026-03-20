# syntax=docker/dockerfile:1
ARG CADDY_VERSION=2.11.2

FROM caddy:${CADDY_VERSION}-builder AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/cloudflare \
    --with github.com/WeidiDeng/caddy-cloudflare-ip \
    --with github.com/mholt/caddy-dynamicdns \
    --with github.com/porech/caddy-maxmind-geolocation \
    --with github.com/hslatman/caddy-crowdsec-bouncer/http \
    --with github.com/hslatman/caddy-crowdsec-bouncer/appsec \
    --with github.com/mholt/caddy-l4 \
    --with github.com/hslatman/caddy-crowdsec-bouncer/layer4

FROM caddy:${CADDY_VERSION}

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
