#!/bin/bash -l

#the above line should ensure that enviroment variables are picked up (/.bashrc or maybe /.profile)

export DOCKER_SCAN_SUGGEST=false

stop_timeout=10
echo stop_timeout=$stop_timeout

set -e; 

function echo_title {
  line=$(echo "$1" | sed -r 's/./-/g')
  printf "\n$line\n$1\n$line\n\n"
}

# goto script directory
pushd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" > /dev/null

tag=$(cat Dockerfile | grep -oP 'cicd="\K\w+' | tail -1)
echo_title tag=$tag
if [ -z "$tag" ] ; then
  printf "\nNo cicd LABEL found in Dockerfile.\n\n"
  exit 1
fi

  echo_title "PULLING LATEST SOURCE CODE"
  git reset --hard
  git pull
  git log --pretty=oneline -1

  echo_title "BUILDING & STARTING CONTAINER"  
  
  docker build . -t $tag
  
  docker run -e "DISPLAY=$DISPLAY" -v "$HOME/.Xauthority:/root/.Xauthority:ro" -d --restart unless-stopped -t --name $tag $tag