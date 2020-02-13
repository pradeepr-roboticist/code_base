#!/bin/bash

xhost +local:root
nvidia-docker run -it \
    --name="ros_container" \
    --rm \
    --env="DISPLAY=$DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --env="XAUTHORITY=$XAUTH" \
    --runtime=nvidia \
    -v$PWD:/workspace \
	ros:codes3 \
	/bin/bash