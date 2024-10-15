#!/bin/bash
# https://github.com/linuxserver/docker-duplicati
# https://github.com/duplicati/duplicati/blob/master/ReleaseBuilder/Resources/Docker/README.md

DOMAIN=❗️❗️❗️
PASSWORD=❗️❗️❗️
docker inspect duplicati_canary | grep DUPLICATI__WEBSERVICE_PASSWORD

docker run -d -p 8500:8200 --name duplicati_canary \
  -v duplicati-data:/data \
  -v ~/_docker-stacks:/_docker-stacks \
  -e "TZ=Asia/Shanghai" \
  -e "DUPLICATI__WEBSERVICE_PASSWORD=$PASSWORD" \
  -e "DUPLICATI__WEBSERVICE_ALLOWED_HOSTNAMES=$DOMAIN" \
  duplicati/duplicati:canary
docker logs -f duplicati_canary

