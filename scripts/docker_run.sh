#!/usr/bin/env bash
set -e

cd "$(dirname "$0")"/..

if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <level_dir> <level_file>" >&2
  exit 1
fi

LEVEL_DIR=$(realpath "$1")
LEVEL_FILE=$2

GUI_SCALE_FACTOR=2

IMAGE_NAME=princess-edit-env

xhost +local:docker > /dev/null
trap 'xhost -local:docker > /dev/null' EXIT

docker run --rm \
    -e DISPLAY=$DISPLAY \
    -e LIBGL_ALWAYS_SOFTWARE=1 \
    --device /dev/dri:/dev/dri \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -v "$(pwd):/workspace" \
    -v "$LEVEL_DIR:/levels" \
    $IMAGE_NAME ./editor "/levels/$LEVEL_FILE" $GUI_SCALE_FACTOR
