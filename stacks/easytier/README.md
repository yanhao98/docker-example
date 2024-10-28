# easytier
- https://www.easytier.top/guide/introduction.html
- [Mac软件打开提示：已损坏，无法打开。您应该将它移到废纸娄](https://blog.csdn.net/Jeremy321321/article/details/136156228)


## 启动
```bash
curl ipinfo.io

REGION="CHINANET-Guangdong"

docker rm -f easytier
docker run -d --restart always --privileged --name easytier --pull always -h ${REGION} \
  --net host \
  -e TZ=Asia/Shanghai \
  --label com.centurylinklabs.watchtower.enable=true \
  easytier/easytier:latest \
  --dhcp --network-name=easytier --external-node=tcp://easytier.1-h.cc:11010
docker logs -f easytier
```

##  Tips
- `11010:11010/tcp` # tcp
- `11010:11010/udp` # udp
- `11011:11011/udp` # wg
- `11011:11011/tcp` # ws
- `11012:11012/tcp` # wss

- 查看子网中的节点信息: `docker exec -it easytier easytier-cli peer`
- 查看子网中的路由信息: `docker exec -it easytier easytier-cli route`
- 查看本节点的信息: `docker exec -it easytier easytier-cli node`
