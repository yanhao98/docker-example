```bash
docker run --rm -p 8092:80 \
	--name getting-started \
	docker/getting-started:latest
```

```bash
docker service create --name global-nginx --mode global --publish 45679:80 nginx:latest
docker service ls
docker service ps global-nginx
docker service ps global-nginx --format "table {{.Name}}\t{{.Node}}\t{{.DesiredState}}\t{{.CurrentState}}\t{{.Ports}}"
docker service logs -f global-nginx -n 10
docker service inspect global-nginx
docker service rm global-nginx
```