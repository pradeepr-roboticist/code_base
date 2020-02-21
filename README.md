# code_base
## What is this?
This repo serves as a convenient template for working with ROS and Docker.
Here are some features.
1) Through the use of a docker image, we are able to avoid a host of problems associated with installing/maintaining a ROS distro. (e.g., The infamous error message "you have held broken packages")
2) Clean seperation of the "catkin_workspace" from a complex ROS setup. This allows for keeping our custom ROS packages in seperate git repositories. We can clone our repositories and compile against any complex ROS setup easily while avoiding all sorts of integration problems like version issues, dependency issues.
3) Allows for GUI applications to run while talking to a roscore backend in a docker container.

## Installing docker and nvidia-docker (version 2)
1. Install nvidia-docker 2.0 by follow instructions the appropriate instructions at https://github.com/NVIDIA/nvidia-docker/wiki/Installation-(version-2.0)#prerequisites

2. Test your docker installation by running the following command:

docker run --runtime=nvidia --rm nvidia/cuda nvidia-smi

You should see your driver details listed on the screen.

## Setting up code_base repository and its workspace

1. Clone this repo at some folder. e.g.

git clone git@github.com:pradeepr-roboticist/code_base.git

2. Go into code_base directory on a terminal. Run the following command:

./docker/prep_host.sh

Once this is done, you will have a "ros_ws" directory in the code_base folder. This is your typical "catkin_ws" but this is used specifically by the docker containers you may run. (See File Organization in diagram below)

## Daily usage
Please refer to diagram at the end of the page for a visual summary.

Working with ROS involves working on multiple terminals at the same time. One of the terminals is a terminal running "roscore". Let's start that up right now.

### Setting up the main terminal ("roscore" terminal)
1. Open up a terminal in code_base. Run the following commands:

./docker/launch.sh

Give it a few seconds. You should already be in the docker container by now. Run the following command:

source rossrc

./workspace/docker/init_ros.sh

### Setting up the other auxiliary terminals
Other terminals that you may open need to talk to the "roscore" terminal. So, you need to "join" the "roscore" terminal by running the following commands.

1. Open up a terminal in code_base. Run the following commands:

./docker/join.sh

source rossrc

2. After this point you are ready to do any of the tasks you normally do in ROS.

e.g. Within ros_ws, you can create packages as you would normally do.

e.g. You can type "rviz" to run Rviz.

e.g. To compile your workspace, run: 

cd /workspace/ros_ws && catkin_build

### Summary
![SummaryDiagram](docker/diagram.png?raw=true "Diagram")

