FROM ubuntu:20.04

WORKDIR /root

ENV TERM=xterm-256color

# Run docker build -t {docker_user}/base -f containers/base/Dockerfile
ADD . devconfig

RUN ./devconfig/install.sh

