#!/usr/bin/env bash
set -e

cd "$(dirname "$0")"/..

IMAGE_NAME=princess-edit-env

docker build -t $IMAGE_NAME .

docker run --rm --user "$(id -u):$(id -g)" -v "$(pwd):/workspace" $IMAGE_NAME make
