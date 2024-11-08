#!/bin/bash

source /environment.sh

# initialize launch file
dt-launchfile-init

# YOUR CODE BELOW THIS LINE
# ----------------------------------------------------------------------------


# NOTE: Use the variable DT_REPO_PATH to know the absolute path to your code
# NOTE: Use `dt-exec COMMAND` to run the main process (blocking process)

# Update ROS repository key
sudo apt-key del F42ED6FBAB17C654
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

# Update package lists
sudo apt-get update

# this is necessary for the camera pipeline to work on the Jetson Nano
if [ "${ROBOT_HARDWARE}" == "jetson_nano" ]; then
    export LD_PRELOAD=${LD_PRELOAD}:/usr/lib/aarch64-linux-gnu/libGLdispatch.so
fi

# set module's health
dt-set-module-healthy

# launching app
dt-exec roslaunch --wait \
    duckiebot_interface all_drivers.launch \
    veh:="$VEHICLE_NAME" \
    robot_type:="$ROBOT_TYPE" \
    robot_configuration:="$ROBOT_CONFIGURATION"


# ----------------------------------------------------------------------------
# YOUR CODE ABOVE THIS LINE

# wait for app to end
dt-launchfile-join
