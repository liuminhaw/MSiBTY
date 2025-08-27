#!/usr/bin/env bash

source ${_SCRIPT_DIR}/libs/helper.sh

execute sudo pacman -Sy --needed go hugo
execute go install golang.org/x/tools/cmd/godoc@latest

# execute cd /tmp  
execute curl --output /tmp/migrate.linux-amd64.tar.gz -L https://github.com/golang-migrate/migrate/releases/download/v4.18.3/migrate.linux-amd64.tar.gz
execute tar -xvzf /tmp/migrate.linux-amd64.tar.gz -C /tmp
execute mv /tmp/migrate ~/go/bin/

