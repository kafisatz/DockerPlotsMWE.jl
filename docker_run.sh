#!/bin/bash -l

#the above line should ensure that enviroment variables are picked up (/.bashrc or maybe /.profile)

export DOCKER_SCAN_SUGGEST=false

stop_timeout=10
echo stop_timeout=$stop_timeout

set -e; 

# goto script directory
pushd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" > /dev/null

tag=$(cat Dockerfile | grep -oP 'cicd="\K\w+' | tail -1)
echo tag=$tag
echo invoking docker run command...
#docker run -e "DISPLAY=$DISPLAY" -v "$HOME/.Xauthority:/root/.Xauthority:ro" -d --restart unless-stopped -t --name $tag $tag

#without -d
docker run -e "DISPLAY=$DISPLAY" -v "$HOME/.Xauthority:/root/.Xauthority:ro" --restart unless-stopped -t --name $tag $tag