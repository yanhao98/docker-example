# unicloud
[Unison](https://github.com/bcpierce00/unison/wiki/Software-for-use-with-Unison#web-interfaces) file sync web interface

[examples/client_server_replica/docker-compose.yml](https://github.com/agarbato/unicloud/blob/8e767790ada4d5c8c04dce0e06ebb3fa4a3a82a8/examples/client_server_replica/docker-compose.yml)

## 准备
1. 进入 https://labs.play-with-docker.com
2. Add new instance 两个
3. docker pull agarbato1/unison-unicloud:2.53.4

## Server

### 启动服务
```bash
cd ~
rm -rf data shares
mkdir -p data shares
chown -R 1000:1000 data
chmod 777 shares
docker run -d --name server \
  --network host \
  -e SERVER_DEBUG=True \
  -e SERVER_UI_USERNAME=admin \
  -e SERVER_UI_PASSWORD= \
  -e ROLE=SERVER \
  --mount type=bind,source=./data,target=/data \
  --mount type=bind,source=./shares,target=/shares \
  agarbato1/unison-unicloud:2.53.4 \
  bash -c "echo 'Port 2222' >> /etc/sshd_config_debug && exec python3 -u start.py"
```


<details>
<summary>检查连接和配置</summary>

#### 检查是否能ping通client
```bash
CLIENT_IP="192.168.0.17"
docker exec -it server ping -c 1 $CLIENT_IP
```
#### 检查sshd配置
```bash
docker exec -it server cat /etc/sshd_config_debug
```
#### 查看sshd日志
```bash
cat ~/data/log/sshd.log
```
</details>


### 添加 share1
在`labs`点`Open Port`打开 80 端口，跳转后打开 http://ip172-18-0-23-csabksol2o90009mnang-80.direct.labs.play-with-docker.com`/shares`


## Client
```bash
curl 192.168.0.18:80/status -v

cd ~
rm -rf data share
mkdir -p data share
chmod 777 data share
docker run -d --name client1 \
  --restart on-failure \
  --network host \
  -e CLIENT_HOSTNAME=client_hostname1 \
  -e ROLE=CLIENT \
  -e SERVER_HOSTNAME=192.168.0.18 \
  -e SERVER_PORT=2222 \
  -e SERVER_SHARE=share1 \
  -e API_PROTOCOL=http \
  -e API_PORT=80 \
  -e SYNC_INTERVAL=15 \
  --mount type=bind,source=./data,target=/data \
  -e CLIENT_DEST=/share \
  --mount type=bind,source=./share,target=/share \
  agarbato1/unison-unicloud:2.53.4
docker logs -f client1
```

### 激活

进 http://ip172-18-0-23-csabksol2o90009mnang-80.direct.labs.play-with-docker.com/`clients`，点击`ACTIVATE`


## 测试同步
```
touch ~/share/$(date +%s).txt
```

```bash
docker exec -it server ls /shares/share1
```