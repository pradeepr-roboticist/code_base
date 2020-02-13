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
print_out_green "Starting roscore ..."
source rossrc && roscore  > /dev/null &

# print_out_green "Setting simulation time ..."
# rosparam set /use_sim_time true
print_out_green "Setting up mongo driver ..."
cd /workspace/external_deps/mongo-cxx-driver && sudo scons --prefix=/usr/local/ --full --use-system-boost --disable-warnings-as-errors
# print_out_green "Making symlinks ..."
# ln -sf /workspace/ros_ws/src/codes3/codes3_ompl/codes3 /workspace/ros_ws/src/ompl/src/ompl/geometric/planners
# rm /workspace/ros_ws/src/moveit/moveit_planners/ompl/ompl_interface/src/parameterization/model_based_state_space.cpp
# rm /workspace/ros_ws/src/moveit/moveit_planners/ompl/ompl_interface/include/moveit/ompl_interface/parameterization/model_based_state_space.h
# ln -sf /workspace/ros_ws/src/codes3/codes3_ompl/model_based_state_space.h /workspace/ros_ws/src/moveit/moveit_planners/ompl/ompl_interface/include/moveit/ompl_interface/parameterization/
# ln -sf /workspace/ros_ws/src/codes3/codes3_ompl/model_based_state_space.cpp /workspace/ros_ws/src/moveit/moveit_planners/ompl/ompl_interface/src/parameterization/
# sudo ln -sf /workspace/ros_ws/devel/lib/libompl.so /opt/ros/melodic/lib/libompl.so
print_out_green "Ready!"