# Run docker build -t {docker_user}/base -f containers/base/Dockerfile
FROM ubuntu:20.04

WORKDIR /root

ENV TERM=xterm-256color

RUN apt-get update && apt-get -y install git

RUN git clone https://github.com/alexansari101/devconfig

RUN ./devconfig/install.sh

CMD ["zsh"]

