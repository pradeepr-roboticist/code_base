#!/bin/bash
set -e
source /opt/ros/melodic/setup.bash

WS1="/workspace/ros_ws"
if [ -d "$WS1/devel" ]
then
source $WS1/devel/setup.bash
fi

exec "$@"
