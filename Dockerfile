FROM ubuntu:14.04

MAINTAINER go_chiba <go.chiba@gmail.com>

RUN apt-get update;

ENV LANG=ja_JP.UTF-8

# Install Utility Packages
RUN apt-get install -y \
    nginx

COPY index.html /usr/share/nginx/html/index.html

ENTRYPOINT ["nginx"]
