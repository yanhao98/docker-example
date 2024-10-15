# docker-example

## [Play With Docker](http://labs.play-with-docker.com/)[^1]

[![Try in PWD](https://raw.githubusercontent.com/play-with-docker/stacks/master/assets/images/button.png)](http://play-with-docker.com?stack=https://raw.githubusercontent.com/Mon-ius/Docker-Warp-Socks/main/dev/warp-socks.yml)
> Click the *CLOSE* button, Replace the $IP with the given one on the top side, then run:
> `curl -x "socks5h://$IP:9091" -fsSL "https://www.cloudflare.com/cdn-cgi/trace"`

ssh 需要加参数` -oHostKeyAlgorithms=+ssh-rsa -oPubkeyAcceptedAlgorithms=+ssh-rsa`
```bash
ssh ip172-18-0-122-cs6efd291nsg0094ibog@direct.labs.play-with-docker.com -oHostKeyAlgorithms=+ssh-rsa -oPubkeyAcceptedAlgorithms=+ssh-rsa
```

---

## [multiarch/qemu-user-static](https://github.com/multiarch/qemu-user-static)
```bash
docker run --rm --privileged multiarch/qemu-user-static:register --reset
```

---
```         
            # type=raw,value=latest,enable=${{ github.ref == format('refs/heads/{0}', 'main') }}
            # type=pep440,pattern={{raw}},enable=${{ startsWith(github.ref, 'refs/tags/') }}

            # type=schedule,pattern={{date 'YYYYMMDD-HHmmss' tz='UTC'}}
            # type=ref,event=branch
            # type=ref,event=pr
            # type=semver,pattern={{version}}
            # type=semver,pattern={{major}}.{{minor}}.{{patch}}
            # type=sha
```


[^1]: [play-with-docker/play-with-docker](https://github.com/play-with-docker/play-with-docker )
