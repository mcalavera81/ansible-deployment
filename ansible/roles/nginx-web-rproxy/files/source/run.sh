#!/usr/bin/env bash

source ./files/colors.sh


if ifconfig docker0 >/dev/null 2>&1; then
    host_ip="$(ifconfig docker0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')"
else
    host_ip="$(echo $DOCKER_HOST | grep -o -E '([0-9]{1,3}\.){3}[0-9]{1,3}')"
fi

if [[ -z "$host_ip" ]]; then
    echo -e "${DARK_RED}Host IP not found! ${RESET}"
    exit 1
else
    echo -e "${DARK_MAGENTA}Host IP resolved: ${host_ip} ${RESET}"
fi


docker run --name webapp-proxy \
            -d -p 80:80 \
            --add-host=host:$host_ip \
            webapp-proxy
