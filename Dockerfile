# Bumped by Renovate (see renovate.json)
ARG CADDY_VERSION=2.11.6

FROM --platform=$BUILDPLATFORM caddy:${CADDY_VERSION}-builder AS builder
ARG TARGETOS TARGETARCH

RUN CGO_ENABLED=0 GOOS=$TARGETOS GOARCH=$TARGETARCH xcaddy build \
    --with github.com/caddy-dns/cloudflare@v0.2.4 \
    --with github.com/hslatman/caddy-crowdsec-bouncer/http@v0.14.1 \
# renovate: branch=main
    --with github.com/WeidiDeng/caddy-cloudflare-ip@f53b62aa13cb7ad79c8b47aacc3f2f03989b67e5 \
# renovate: branch=master
    --with github.com/mholt/caddy-dynamicdns@67d107a42c0279f6e6d58a6afe646745c8b44f78 \
# renovate: branch=master
    --with github.com/mholt/caddy-ratelimit@5625512f24f6f59d6f64fb3aafe5eecff0b286db

FROM caddy:${CADDY_VERSION}
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
