# oes in luci


## frpc
```
docker pull seanly/oes-in-luci
docker run -d \
  --name luci \
  --restart unless-stopped \
  --privileged \
  -p 80:80 \
  -p 7682:7682 \
  -e TZ=Asia/Shanghai \
  -v $HOME/pods/luci:/external:rslave \
  -v /media:/media:rshared \
  -v /dev:/dev:rslave \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --tmpfs /tmp:exec \
  --tmpfs /run \
  seanly/oes-in-luci
```

