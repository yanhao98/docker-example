# [unicloud](https://github.com/agarbato/unicloud) is a web interface to unison.

[play-with-docker.md](./play-with-docker.md)

## Server

### 启动服务端
```bash
mkdir -p /unison-unicloud/data /unison-unicloud/shares
chown -R 0:0 /unison-unicloud/data
chmod 777 /unison-unicloud/shares
```

```bash
SSH_PORT=2222
HTTP_PORT=5001
SERVER_UI_PASSWORD=

docker run -d --restart unless-stopped --name unison-unicloud-server \
  -p $SSH_PORT:22 -p $HTTP_PORT:80 \
  -e TZ=Asia/Shanghai \
  -e USER=root -e USER_UID=0 \
  -e SERVER_UI_USERNAME=unison-unicloud-admin \
  -e SERVER_UI_PASSWORD=$SERVER_UI_PASSWORD \
  -e ROLE=SERVER \
  --mount type=bind,source=/unison-unicloud/data,target=/data \
  --mount type=bind,source=/unison-unicloud/shares,target=/shares \
  ghcr.io/yanhao98/unicloud:latest
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
# chown -R 1000:1000 /unison-unicloud/data
```

```bash
CLIENT_HOSTNAME=服务器主机名
SERVER_SHARE=share1 # 需要在服务器上先创建
SOURCE1=/path/to/backup1
SERVER_PORT=2222

docker run -d --name unison-unicloud-client \
  -e SHARE_IGNORE="mysql.sock|.unison" \
  -e UNISON_PARAMS="group=true|owner=true|times=true" \
  -e TZ=Asia/Shanghai \
  -e USER=root -e USER_UID=0 \
  --restart on-failure \
  -e CLIENT_HOSTNAME=$CLIENT_HOSTNAME \
  -e ROLE=CLIENT \
  -e SERVER_HOSTNAME=unison-unicloud-server.oo1.dev \
  -e SERVER_PORT=$SERVER_PORT \
  -e SERVER_SHARE=$SERVER_SHARE \
  -e API_PROTOCOL=https \
  -e API_PORT=443 \
  -e SYNC_INTERVAL=15 \
  --mount type=bind,source=/unison-unicloud/data,target=/data \
  -e CLIENT_DEST=/share \
  --mount type=bind,source=$SOURCE1,target="/share$SOURCE1" \
  ghcr.io/yanhao98/unicloud:latest
docker logs -f unison-unicloud-client
```

```bash
docker exec -it unison-unicloud-client tail -f /data/log/client.log
docker exec -it unison-unicloud-client tail -f /data/log/supervisord.log
docker exec -it unison-unicloud-client tail -f /data/log/unicloud-supervise-err.log
docker exec -it unison-unicloud-client tail -f /data/log/unicloud-supervise-std.log
```