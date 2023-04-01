# vim: ft=dockerfile
FROM alpine:edge as ssd

COPY ./ssd /code
WORKDIR /code

RUN apk update && \
    apk add gcc g++ libc-dev && \
    gcc start-stop-daemon.c -o start-stop-daemon && \
    chmod 750 start-stop-daemon

FROM lisaac/luci:latest
# https://github.com/lisaac/luci-in-docker

RUN apk update && \
    apk add neovim bash busybox-extras git 

COPY --from=ssd /code/start-stop-daemon /usr/bin/start-stop-daemon

ENV FRP_VER=0.47.0
ENV FRP_URL=https://github.com/fatedier/frp/releases/download/v${FRP_VER}/frp_${FRP_VER}_linux_amd64.tar.gz

RUN wget -c ${FRP_URL} -O - | tar -xz --strip-components=1 -C /usr/bin/ &&\
    git clone --depth 1 https://github.com/seanly/luci-app-frpc.git $INTERNAL_PLUGIN_DIR/luci-app-frpc

RUN mkdir -p $LUCI_SYSROOT/etc/rc.d/
