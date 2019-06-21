#!/bin/sh
docker rm -f $(docker ps -qa)
docker rmi `docker images -q`
docker volume rm $(docker volume ls -q)
cleanupdirs="/data /var/log/harbor /etc/docker/certs.d ~/.docker"
for dir in $cleanupdirs; do
  echo "Removing $dir"
  rm -rf $dir
done

systemctl restart docker
