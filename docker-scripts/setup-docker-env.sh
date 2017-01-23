#!/usr/bin/env bash

node=${1:-swarm-01.hivr.dev}

echo "Setting up environment for node: $node"
eval $(docker-machine env $node)
