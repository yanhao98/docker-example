# Watchtower

```bash
RUN_ONCE=true # 是否只运行一次
CONTAINER_NAME="" # 如果不设置 container_name，则会监控所有容器
DOCKER_ARGS=()
WATCHTOWER_ARGS=()
WATCHTOWER_ARGS=(--cleanup)
WATCHTOWER_ARGS=(--remove-volumes)
WATCHTOWER_ARGS=(--rolling-restart)

if [ "$RUN_ONCE" = true ]; then
  WATCHTOWER_ARGS+=(--run-once)
  DOCKER_ARGS+=(--rm)
else
  DOCKER_ARGS+=(-d)
  DOCKER_ARGS+=(--restart unless-stopped)
  DOCKER_ARGS+=(--name watchtower)
fi

if [ -f ~/.docker/config.json ]; then # 如果 ~/.docker/config.json 存在
  DOCKER_ARGS+=(-v ~/.docker/config.json:/config.json)
fi

docker run "${DOCKER_ARGS[@]}" \
  -e TZ=Asia/Shanghai \
  -v /var/run/docker.sock:/var/run/docker.sock \
  containrrr/watchtower "${WATCHTOWER_ARGS[@]}" $CONTAINER_NAME
```

---
**邮件通知**

```bash
  -e WATCHTOWER_NOTIFICATIONS=email \
  -e WATCHTOWER_NOTIFICATION_EMAIL_FROM=❗️❗️❗️ \
  -e WATCHTOWER_NOTIFICATION_EMAIL_TO=❗️❗️❗️ \
  -e WATCHTOWER_NOTIFICATION_EMAIL_SERVER=❗️❗️❗️ \
  -e WATCHTOWER_NOTIFICATION_EMAIL_SERVER_PORT=465 \
  -e WATCHTOWER_NOTIFICATION_EMAIL_SERVER_USER=❗️❗️❗️ \
  -e WATCHTOWER_NOTIFICATION_EMAIL_SERVER_PASSWORD=❗️❗️❗️ \
  -e WATCHTOWER_NOTIFICATION_EMAIL_DELAY=2 \
  -e WATCHTOWER_NOTIFICATIONS_HOSTNAME="$(hostname)" \
```