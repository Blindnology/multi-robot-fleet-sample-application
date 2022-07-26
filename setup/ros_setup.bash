#!/bin/bash

echo "###############################################################################"
echo "ROS environment setup starting.."
echo "###############################################################################"

BASE_DIR=`pwd`
APP_DIR=$BASE_DIR/simulation_ws

# Wait if apt is running. 
while :
do
    count=`ps -ef | grep apt.systemd.daily | grep lock_is_held | grep -v grep | wc -l`
    if [ $count = 0 ]; then
        break
    else
        echo "System update is running.. Wait until the completion"
        sleep 10
    fi
done

sudo apt-get update
source /opt/ros/$ROS_DISTRO/setup.sh

#download 3rd party repositories 
cd $APP_DIR
wstool update

#Update source list
cd $BASE_DIR
# Setup custom rosdep dependencies
CUSTOM_DEP_SOURCE_LIST_LOCATION=/etc/ros/rosdep/sources.list.d/21-customdependencies.list
CUSTOM_DEP_FILE=$BASE_DIR/setup/custom_dependencies.yaml

if [ -f "$CUSTOM_DEP_SOURCE_LIST_LOCATION" ]; then
    echo "rosdep file already exists. Skipping"
else
    sudo touch $CUSTOM_DEP_SOURCE_LIST_LOCATION
    if grep -Fxq "yaml file://$CUSTOM_DEP_FILE" $CUSTOM_DEP_SOURCE_LIST_LOCATION
    then
        echo "dependency file already setup"
    else
        echo "source list not setup"
        echo "yaml file://$CUSTOM_DEP_FILE" | sudo tee -a $CUSTOM_DEP_SOURCE_LIST_LOCATION
    fi
fi

cd $APP_DIR
rosdep update
rosdep install --from-paths src --ignore-src -r -y

sudo apt-get install python3-apt python3-pip -y
sudo pip3 install -U setuptools pip

catkin build
source devel/setup.bash

# add exports
source ../export.sh
