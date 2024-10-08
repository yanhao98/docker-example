# docker-example

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