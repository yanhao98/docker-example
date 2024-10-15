# Duplicati
- https://github.com/linuxserver/docker-duplicati
- https://github.com/duplicati/duplicati/blob/master/ReleaseBuilder/Resources/Docker/README.md

## 启动
```bash
DUPLICATI_DOMAIN=❗️❗️❗️
DUPLICATI_PASSWORD=❗️❗️❗️
docker run -d -p 8500:8200 --name duplicati_canary \
  -v duplicati-data:/data \
  -v ~/_docker-stacks:/_docker-stacks \
  -e "TZ=Asia/Shanghai" \
  -e "DUPLICATI__WEBSERVICE_ALLOWED_HOSTNAMES=$DUPLICATI_DOMAIN" \
  -e "DUPLICATI__WEBSERVICE_PASSWORD=$DUPLICATI_PASSWORD" \
  duplicati/duplicati:canary
docker logs -f duplicati_canary
```

## 访问
```bash
DUPLICATI_DOMAIN=$(docker inspect duplicati_canary | grep DUPLICATI__WEBSERVICE_ALLOWED_HOSTNAMES | awk -F '=' '{gsub(/",$/, "", $2); print $2}');
DUPLICATI_PASSWORD=$(docker inspect duplicati_canary | grep DUPLICATI__WEBSERVICE_PASSWORD | awk -F '=' '{gsub(/",$/, "", $2); print $2}');
URL="http://$DUPLICATI_DOMAIN:8500/login.html?password=$DUPLICATI_PASSWORD";
echo "🌐";
echo "$URL";
echo "🌐";
```