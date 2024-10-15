# docker-example

## [Play With Docker](http://labs.play-with-docker.com/)
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