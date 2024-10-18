# Duplicati
- https://github.com/linuxserver/docker-duplicati
- https://github.com/duplicati/duplicati/blob/master/ReleaseBuilder/Resources/Docker/README.md

```bash
docker run --rm -it --entrypoint bash duplicati/duplicati:canary
/opt/duplicati/duplicati-cli help
```

## 启动
```bash
DUPLICATI_DOMAIN=❗️❗️❗️
DUPLICATI_PASSWORD=❗️❗️❗️
docker run -d -p 8500:8200 --restart unless-stopped --name duplicati_canary \
  -v duplicati-data:/data \
  --mount type=bind,source=~/_docker-stacks,target/_docker-stacks \
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
URL="$DUPLICATI_DOMAIN:8500/login.html?password=$DUPLICATI_PASSWORD";
echo "🌐http://"
echo "$URL";
echo "🌐";
```

## 配置

`:8500/ngax/index.html#/settings`

```ini
--machine-id=⚠️

--send-mail-url=smtps://smtp.resend.com:2465
--send-mail-username=resend
--send-mail-password=⚠️
--send-mail-from=Duplicati <notifications@⚠️>
--send-mail-to=⚠️
--send-mail-level=Warning,Error,Fatal
--send-mail-any-operation=true
--send-mail-subject=%OPERATIONNAME% 👉🏻%PARSEDRESULT%👈🏻 for %backup-name%
--send-mail-body=%RESULT%

--send-http-url=
--send-http-result-output-format=Json
```

## Remote access control

https://app.duplicati.com/app/dashboard