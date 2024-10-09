#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

apt update

apt -y install \
    net-tools \
    mysql-server \
    nodejs \
    npm \
    pkg-config \
    default-libmysqlclient-dev \
    nginx

node -v
npm -v

mkdir /home/ubuntu/myapp
cd /home/ubuntu/myapp

npm install
npm run start