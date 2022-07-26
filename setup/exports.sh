#!/bin/bash

export ROBOT_NAME=Itay  # unique robot name
export ROSBRIDGE_STATE=CLIENT  # SERVER or CLIENT
export ROSBRIDGE_IP=52.214.163.151  # localhost for SERVER. IP of rosbridge for CLIENT
export START_X=0  # start location of robot
export START_Y=0
export START_YAW=0
export HUSKY_REALSENSE_ENABLED=true
export HUSKY_LMS1XX_ENABLED=true
export USE_CUSTOM_MOVE_OBJECT_GAZEBO_PLUGIN=true  # set to true if you use custom plugin to move robot. False uses regular gazebo rostopics
export GAZEBO_PLUGIN_PATH=/home/ubuntu/multi-robot-fleet-sample-application/simulation_ws/build/robot_fleet:$GAZEBO_PLUGIN_PATH