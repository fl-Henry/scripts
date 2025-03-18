
# Docker commands

### remove all containers
```bash
# bash
docker rm -f $(docker ps -a -q)
```
```powershell
# powershell
docker ps -aq | % { docker stop $_ } | % { docker rm $_ }
docker ps -aq | % { docker stop $_ }
docker ps -aq | % { docker rm $_ }
```

### directory and port mapping
```bash
docker run example 
    -v VOLUME (share dir) hypervisor:container
    -p port hypervisor:container

# Examples
# docker run --rm -it -v $(pwd)/app:/root/app -p 5900:5900 myparts_ge bash
# docker run --rm -it -v $(pwd)/app:/root/app ultrafunk/undetected-chromedriver
# docker run --rm -it -v $(pwd)/app:/root/app ultrafunk/undetected-chromedriver ipython /root/app/app.py

```
### ls all containers
```bash
docker ps -a  
```

### list containers
```bash
docker container ls
```

### commit container
```bash
docker container commit 39ce183cf3f5 flhenry/myparts_ge:latest
docker container commit bb34dc85e85c lashagurgenidze/myparts_ge
```

### push container
```bash
docker push flhenry/myparts_ge:latest
docker push lashagurgenidze/myparts_ge
```
### retag
```bash
docker manifest create $REPOSITORY:$TAG_NEW $REPOSITORY:$TAG_OLD
docker manifest push $REPOSITORY:$TAG_NEW
```