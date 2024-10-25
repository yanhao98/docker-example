****# sything
[![Try in PWD](https://raw.githubusercontent.com/play-with-docker/stacks/master/assets/images/button.png)](http://play-with-docker.com?stack=https://raw.githubusercontent.com/yanhao98/docker-example/refs/heads/main/stacks/sything/docker-compose-pwd.yml)
```bash
wget https://raw.githubusercontent.com/yanhao98/docker-example/refs/heads/main/stacks/sything/docker-compose.yml && docker-compose up -d
```

## st-1
```bash
HOSTNAME=服务器主机名
SOURCE1=/path/to/backup1

TARGET1="/host$SOURCE1"
docker run -d --restart unless-stopped --name syncthing \
  -h $HOSTNAME \
  --mount type=bind,source=$SOURCE1,target=$TARGET1 \
  --mount type=volume,source=st-sync-cfg,target=/var/syncthing/config \
  -e PUID=0 -e PGID=0 -e TZ=Asia/Shanghai \
  -p 28198:8384 -p 22000:22000/tcp -p 22000:22000/udp -p 21027:21027/udp \
  syncthing/syncthing

echo -e "\n Folder Path: $TARGET1 \n"
```

- 访问`https://服务器ip:28198`
- 设置用户名密码
- 添加文件夹: 文件夹路径固定填`/host$SOURCE1`

```bash
docker exec -it syncthing find /host -maxdepth 3

tree /root/st-folder -L 3
```