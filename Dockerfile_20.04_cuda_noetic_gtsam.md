# Use the base image with PyTorch and CUDA support
FROM pytorch/pytorch:2.0.1-cuda11.7-cudnn8-devel

ENV DEBIAN_FRONTEND=noninteractive

# tzdata
RUN apt-get update && \
    apt-get install -y tzdata && \
    ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime && \
    echo "Asia/Seoul" > /etc/timezone && \
    apt-get clean

RUN apt-get install -y git unzip wget
RUN apt-get install -y libeigen3-dev freeglut3-dev libsm6 libxext6 libxrender-dev libgl1-mesa-glx libglib2.0-0

# Update and install necessary tools
RUN apt-get update && apt-get install -y \
    locales \
    curl \
    gnupg2 \
    lsb-release \
    build-essential

# ROS Noetic
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -
RUN apt-get update
RUN apt install ros-noetic-desktop-full -y

# GTSAM
RUN mkdir -p ~/thirdParty && cd ~/thirdParty
RUN git clone https://github.com/borglab/gtsam.git
RUN cd gtsam
RUN mkdir -p build && cd build
RUN cmake ..
RUN make install -j8

COPY ./entrypoint.sh /
RUN chmod 755 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["bash"]
