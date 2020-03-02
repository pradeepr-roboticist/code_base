
FROM osrf/ros:melodic-desktop-full
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}

ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update && apt-get install -y sudo && rm -rf /var/lib/apt/lists/*

# create non-root user
ENV USERNAME ros
RUN adduser --ingroup sudo --disabled-password --gecos "" --shell /bin/bash --home /home/$USERNAME $USERNAME
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN bash -c 'echo $USERNAME:ros | chpasswd'
ENV HOME /home/$USERNAME
USER $USERNAME


RUN sudo apt-get update && sudo apt-get install -y --allow-unauthenticated \
net-tools \
iputils-ping \
apt-utils \
build-essential \
psmisc \
vim-gtk \
python-catkin-tools \
mongodb \
scons \
 && sudo rm -rf /var/lib/apt/lists/*

############### install vscode #########################
#RUN sudo apt-get update && sudo apt-get install -y software-properties-common apt-transport-https wget && sudo rm -rf /var/lib/apt/lists/*
#RUN wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
#RUN sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
#RUN sudo apt-get update && sudo apt-get install -y code

#RUN code --install-extension ms-vscode.cpptools && \
#code --install-extension ms-iot.vscode-ros && \
#code --install-extension ms-python.python && \
#code --install-extension ms-vscode.cmake-tools && \
#code --install-extension twxs.cmake
#######################################################

RUN sudo apt-get update && sudo apt-get install -y \
ros-melodic-moveit \
ros-melodic-mongodb-store \
&& sudo rm -rf /var/lib/apt/lists/*

## These packages are extracted from the command:
## rosdep install -y -s --from-paths /workspace/ros_ws/src --ignore-src --rosdistro=melodic
RUN sudo apt-get update && sudo apt-get install -y \
ros-melodic-panda-moveit-config \
ros-melodic-joy-teleop \
ros-melodic-graph-msgs \
libqt5x11extras5-dev \
ros-melodic-ros-pytest \
ros-melodic-joy \
ros-melodic-joint-trajectory-controller \
ros-melodic-moveit-resources \
ros-melodic-rosparam-shortcuts \
ros-melodic-effort-controllers \
ros-melodic-gmapping \
ros-melodic-rtabmap-ros \
ros-melodic-navigation \
ros-melodic-teb-local-planner \
&& sudo rm -rf /var/lib/apt/lists/*

# This is needed to prevent the use of default version of OMPL shipped with moveit
RUN sudo apt-get remove -y ros-melodic-ompl

RUN sudo apt-get update && sudo apt-get install -y \
ca-certificates \
&& sudo rm -rf /var/lib/apt/lists/*

## Add further dependencies over here. e.g. package_1 and package_2 are going to be installed below
#RUN sudo apt-get update && sudo apt-get install -y \
# package_1 \
# package_2 \
#&& sudo rm -rf /var/lib/apt/lists/*

COPY ros_entrypoint.sh /bin/rossrc

ENTRYPOINT [ "rossrc" ]
