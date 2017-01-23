#!/usr/bin/env bash

usage="Usage: $0 -k <generic-ssh-key> -u <generic-ssh-user> -w <generic-ip-address> machine-name"

while getopts ":k:u:w:" opt; do
    case $opt in
        k)  ssh_key=$OPTARG
             ;;
        u)  ssh_user=$OPTARG
             ;;
        w)  ip_address=$OPTARG
             ;;
        \?) echo $usage
             exit 1 ;;
    esac
done

if [ -z $ssh_key ] || [ -z $ssh_user ] || [ -z $ip_address ];then
    echo $usage
    exit 1
fi

shift $(($OPTIND - 1))

if [ $# != 1 ];then
    echo $usage
    exit 1
fi

echo "Running docker-machine with: "
echo "generic-ssh-keys: $ssh_key"
echo "generic-ssh-user: $ssh_user"
echo "ip-address:       $ip_address"

docker-machine create  --driver generic \
    --generic-ssh-key  $ssh_key\
    --generic-ssh-user $ssh_user \
    --generic-ip-address $ip_address \
    $1


