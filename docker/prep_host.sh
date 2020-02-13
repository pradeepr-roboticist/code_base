#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color
print_out_red()
{
    echo -e "${RED}$1${NC}"
}
print_out_green()
{
    echo -e "${GREEN}$1${NC}"
}

WS_ROOT="/workspace"
ROS_WS_ROOT_DIR="ros_ws"
ROS_WS_PATH="$WS_ROOT/$ROS_WS_ROOT_DIR"
EXTERNAL_DEPS_ROOT_DIR="external_deps"
EXTERNAL_DEPS_PATH="$WS_ROOT/$EXTERNAL_DEPS_ROOT_DIR"
print_out_green "Building docker image ..."
docker build --rm -t ros:codes3 ./docker
print_out_green "Built docker image"
docker run --rm -e "ROS_WS_PATH=$ROS_WS_PATH" -e "WS_ROOT=$WS_ROOT" -e "EXTERNAL_DEPS_PATH=$EXTERNAL_DEPS_PATH" -v$PWD:$WS_ROOT -it ros:codes3 /bin/bash $WS_ROOT/docker/prep_ws.sh
# cd ./$ROS_WS_PATH/src && git clone git@github.com:pradeepr-roboticist/codes3.git