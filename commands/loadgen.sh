#!/bin/bash

# exit on error
set -e
# log every command
set -x

echo $(pos_get_variable hostname)

# update apt-get
DEBIAN_FRONTEND=noninteractive apt-get update -y 
DEBIAN_FRONTEND=noninteractive apt-get install dialog apt-utils -y

# install sysstat
DEBIAN_FRONTEND=noninteractive apt-get install sysstat -y

# install mosquitto
DEBIAN_FRONTEND=noninteractive apt-get install mosquitto -y

# install java
DEBIAN_FRONTEND=noninteractive apt-get install default-jre -y

# install our repo
PLANS_REPO=$(pos_get_variable plans/repo)

echo "Cloning $GIT_REPO"
git clone --recursive $PLANS_REPO

# create directory for results
mkdir results

echo 'all done'
echo 'start test 1'
sh ./test1_loadgen.sh
