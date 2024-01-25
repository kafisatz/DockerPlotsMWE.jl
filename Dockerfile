# syntax = docker/dockerfile:1.2
#choose a base image
#FROM julia:1.9.3
#FROM julia:1.9.4-alpine #alpine has no apt (but apk)
FROM julia:1.9.4-bookworm

# mark it with a label, so we can remove dangling images
LABEL cicd="dockerplotsmwe"

#https://vsupalov.com/buildkit-cache-mount-dockerfile/
ENV PIP_CACHE_DIR=/var/cache/buildkit/pip
RUN mkdir -p $PIP_CACHE_DIR
RUN rm -f /etc/apt/apt.conf.d/docker-clean
#RUN --mount=type=cache,target=/var/cache/apt apt-get update && apt-get install -yqq --no-install-recommends wget git iputils-ping && rm -rf /var/lib/apt/lists/*

ENV TZ="Europe/Zurich" USER=root USER_HOME_DIR=/home/${USER} JULIA_DEPOT_PATH=${USER_HOME_DIR}/.julia NOTEBOOK_DIR=${USER_HOME_DIR}/notebooks JULIA_NUM_THREADS=1

####################################
#Install python and pip 
RUN apt-get update 
RUN apt-get install -y software-properties-common gcc
#RUN add-apt-repository -y ppa:deadsnakes/ppa
#RUN apt-get update 
RUN apt-get install -y python3.10 python3-distutils python3-pip python3-apt
RUN apt-get install -y python3-full

#install pkg
#https://stackoverflow.com/questions/77028925/docker-compose-fails-error-externally-managed-environment
RUN pip3 install playwright --break-system-packages
RUN playwright install-deps
RUN playwright install
RUN playwright install-deps

### QT and display
RUN apt-get update && \
    apt-get install -y libqt5gui5 && \
    rm -rf /var/lib/apt/lists/*
ENV QT_DEBUG_PLUGINS=1

#copy Julia package
RUN mkdir -p /usr/local/DockerPlotsMWE.jl
COPY . /usr/local/DockerPlotsMWE.jl

#set workdir
WORKDIR /usr/local/DockerPlotsMWE.jl

#install dependencies 
RUN julia /usr/local/DockerPlotsMWE.jl/deps/dockerdeps.jl

########################################################################
#enviroment variables
########################################################################
#ARG QBITTORRENT_PASSWORD
#ENV QBITTORRENT_PASSWORD $QBITTORRENT_PASSWORD

########################################################################
#run Tests
########################################################################
#RUN julia --project=@. -e "import Pkg;Pkg.test()"

########################################################################
#run application 
########################################################################
USER root
#start julia script
#ENTRYPOINT ["julia", "-p 1"]
ENTRYPOINT ["julia"]
CMD ["src/start.jl"]
#working dir is set as DockerPlotsMWE.jl