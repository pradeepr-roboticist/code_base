#!/bin/bash

rossrc
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

if [ -d $EXTERNAL_DEPS_PATH ]
then
    print_out_red "$EXTERNAL_DEPS_PATH exists. Doing nothing."
else
    print_out_green "Making $EXTERNAL_DEPS_PATH and cloning packages ..."
    mkdir -p $EXTERNAL_DEPS_PATH
    # Setup mongo driver (see https://moveit.ros.org/install/source/dependencies/)
    cd $EXTERNAL_DEPS_PATH && git clone -b 26compat https://github.com/mongodb/mongo-cxx-driver.git
    print_out_green "Setting up mongo-cxx-driver ..."
    cd $EXTERNAL_DEPS_PATH/mongo-cxx-driver && sudo scons --prefix=/usr/local/ --full --use-system-boost --disable-warnings-as-errors
    print_out_green "Done setting up mongo-cxx-driver ..."
fi

if [ -d $ROS_WS_PATH ]
then
    print_out_red "$ROS_WS_PATH exists. Doing nothing."
else
    print_out_green "Making $ROS_WS_PATH and downloading packages ..."
    mkdir -p $ROS_WS_PATH/src/ && cd $ROS_WS_PATH/src/ && catkin_init_workspace
    sudo rosdep init
    rosdep update

    cd $ROS_WS_PATH/src/ && git clone -b melodic-devel https://github.com/ros-industrial/universal_robot.git

    cd $ROS_WS_PATH/src/ && wstool init .
    wstool merge -t . https://raw.githubusercontent.com/ros-planning/moveit/master/moveit.rosinstall
    wstool update -t .

    cd $ROS_WS_PATH/src/ && git clone https://github.com/ompl/ompl
    # cd ompl && wget https://raw.githubusercontent.com/ros-gbp/ompl-release/debian/kinetic/xenial/ompl/package.xml

    cd $ROS_WS_PATH/src/ && git clone https://github.com/IFL-CAMP/iiwa_stack.git

    # # Setup mongo warehouse
    # wstool set -yu warehouse_ros_mongo --git https://github.com/ros-planning/warehouse_ros_mongo.git -v jade-devel
    # wstool set -yu warehouse_ros --git https://github.com/ros-planning/warehouse_ros.git -v jade-devel
    cd $ROS_WS_PATH/src/ && git clone https://github.com/ros-planning/warehouse_ros_mongo.git -v jade-devel
    cd $ROS_WS_PATH/src/ && git clone https://github.com/ros-planning/warehouse_ros.git -v jade-devel


    cd $ROS_WS_PATH && rosdep install -y --from-paths $ROS_WS_PATH --ignore-src --rosdistro=melodic
    print_out_green "Building $ROS_WS_PATH ..."
    cd $ROS_WS_PATH && catkin build
fi
