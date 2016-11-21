FROM ubuntu:14.04

MAINTAINER go_chiba <go.chiba@gmail.com>

RUN sed -i "s/http:\/\/httpredir.debian.org\/debian/http:\/\/ftp.tw.debian.org\/debian\//g" /etc/apt/sources.list

RUN apt-get update;

ENV LANG=ja_JP.UTF-8

# Install Utility Packages
RUN apt-get install -y \
    wget \
    git \
    exuberant-ctags

# Install/Configure Japanese Env
RUN apt-get install -y \
    language-pack-ja-base \
    language-pack-ja \
    fonts-ipafont-gothic \
    fontconfig
RUN dpkg-reconfigure locales
RUN fc-cache -fv

# Install Vim
RUN apt-get install -y \
    vim

# Install Neobundle
# RUN mkdir -p ~/.vim/bundle
# RUN git clone https://github.com/Shougo/neobundle.vim.git ~/.vim/bundle/neobundle.vim
RUN git clone https://github.com/Shougo/neobundle.vim.git ~/.vim/bundle/neobundle.vim | sh

COPY .vimrc /root/.vimrc
ENV TERM=xterm-256color

# Install Go
RUN wget https://storage.googleapis.com/golang/go1.5.3.linux-amd64.tar.gz -O /tmp/go1.5.3.linux-amd64.tar.gz
RUN tar -C /usr/local -zxvf /tmp/go1.5.3.linux-amd64.tar.gz
COPY go.vim /root/.vim/ftplugin/go.vim

ENV GOROOT=/usr/local/go
ENV GOPATH=/root/go
ENV PATH=$GOROOT/bin:$PATH

ENTRYPOINT ["/bin/bash"]
