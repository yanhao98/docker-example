# [unicloud](https://github.com/agarbato/unicloud) is a web interface to unison.

[play-with-docker](./play-with-docker.md)

## Server

### 启动服务端
```bash
mkdir -p /unison-unicloud/data /unison-unicloud/shares
chown -R 1000:1000 /unison-unicloud/data
chmod 777 /unison-unicloud/shares
```

```bash
SSH_PORT=2222
HTTP_PORT=5001
SERVER_UI_PASSWORD=

docker run -d --restart unless-stopped --name unison-unicloud-server \
  -p $SSH_PORT:22 -p $HTTP_PORT:80 \
  -e TZ=Asia/Shanghai \
  -e SERVER_UI_USERNAME=unison-unicloud-admin \
  -e SERVER_UI_PASSWORD=$SERVER_UI_PASSWORD \
  -e ROLE=SERVER \
  --mount type=bind,source=/unison-unicloud/data,target=/data \
  --mount type=bind,source=/unison-unicloud/shares,target=/shares \
  agarbato1/unison-unicloud:2.53.4
docker logs -f unison-unicloud-server
```

#### 查看密码
```bash
docker inspect unison-unicloud-server | grep -A 1 -B 1 -i password
```



## Client
```bash
curl https://unison-unicloud-server.oo1.dev/status -v
```

```bash
mkdir -p /unison-unicloud/data
chown -R 1000:1000 /unison-unicloud/data
```

```bash
CLIENT_HOSTNAME=服务器主机名
SERVER_SHARE=share1
SHARE_PATH_SOURCE=/unison-unicloud/share

docker run -d --name unison-unicloud-client \
  -e TZ=Asia/Shanghai \
  --restart on-failure \
  -e CLIENT_HOSTNAME=$CLIENT_HOSTNAME \
  -e ROLE=CLIENT \
  -e SERVER_HOSTNAME=unison-unicloud-server.oo1.dev \
  -e SERVER_PORT=2222 \
  -e SERVER_SHARE=$SERVER_SHARE \
  -e API_PROTOCOL=https \
  -e API_PORT=443 \
  -e SYNC_INTERVAL=15 \
  --mount type=bind,source=/unison-unicloud/data,target=/data \
  -e CLIENT_DEST=/share \
  --mount type=bind,source=$SHARE_PATH_SOURCE,target=/share \
  agarbato1/unison-unicloud:2.53.4
docker logs -f unison-unicloud-client
```