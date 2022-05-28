#!/usr/bin/env bash

clear

echo "██████   ██████  ███████     ██████  ";
echo "██   ██ ██    ██ ██               ██ ";
echo "██████  ██    ██ ███████      █████  ";
echo "██   ██ ██    ██      ██     ██      ";
echo "██   ██  ██████  ███████     ███████ ";
echo "                                     ";
echo "                                     ";

printf "\n[!] Setting locale ...\n"
sudo apt update && sudo apt install locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

printf "\n[!] Adding Universe & Multiverse Repository ...\n"
sudo apt install software-properties-common
sudo add-apt-repository universe
sudo add-apt-repository multiverse
sudo apt update

printf "\n[!] Authorize GPG Key with APT ...\n"
sudo apt install curl gnupg lsb-release
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

printf "\n[!] Adding ROS2 Repository to sources list ...\n"
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(source /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

printf "\n[!] Installing Development Tools and ROS tools ...\n"
sudo apt update && sudo apt install -y \
  build-essential \
  cmake \
  git \
  python3-colcon-common-extensions \
  python3-flake8 \
  python3-flake8-blind-except \
  python3-flake8-builtins \
  python3-flake8-class-newline \
  python3-flake8-comprehensions \
  python3-flake8-deprecated \
  python3-flake8-docstrings \
  python3-flake8-import-order \
  python3-flake8-quotes \
  python3-pip \
  python3-pytest \
  python3-pytest-cov \
  python3-pytest-repeat \
  python3-pytest-rerunfailures \
  python3-rosdep \
  python3-setuptools \
  python3-vcstool \
  wget

printf "\n[!] Creating a Workspace and Clone ROS2 Repositories ...\n"
mkdir -p ~/ros2_humble/src
cd ~/ros2_humble
wget https://raw.githubusercontent.com/ros2/ros2/humble/ros2.repos
vcs import src < ros2.repos

printf "\n[!] Installing Dependencies using Rosdep ...\n"
sudo apt upgrade
sudo rosdep init
rosdep update
rosdep install --from-paths src --ignore-src -y --skip-keys "fastcdr rti-connext-dds-6.0.1 urdfdom_headers"

printf "\n[!] ...\n"
cd ~/ros2_humble/
colcon build --symlink-install


echo "███████ ███    ██ ██    ██     ███████ ███████ ████████ ██    ██ ██████  ";
echo "██      ████   ██ ██    ██     ██      ██         ██    ██    ██ ██   ██ ";
echo "█████   ██ ██  ██ ██    ██     ███████ █████      ██    ██    ██ ██████  ";
echo "██      ██  ██ ██  ██  ██           ██ ██         ██    ██    ██ ██      ";
echo "███████ ██   ████   ████       ███████ ███████    ██     ██████  ██      ";
echo "                                                                         ";
echo "                                                                         ";


printf "\n[!] Adding setup file to .bashrc ...\n"
echo ". ~/ros2_humble/install/local_setup.bash" > ~/.bashrc
source ~/.bashrc


echo "██████   ██████  ███    ██ ███████     ██ ";
echo "██   ██ ██    ██ ████   ██ ██          ██ ";
echo "██   ██ ██    ██ ██ ██  ██ █████       ██ ";
echo "██   ██ ██    ██ ██  ██ ██ ██             ";
echo "██████   ██████  ██   ████ ███████     ██ ";
echo "                                          ";
echo "                                          ";
