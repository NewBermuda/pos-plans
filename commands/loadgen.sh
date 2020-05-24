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

# create directory for results
mkdir results

mosquitto -p 1930 -v -d

echo 'all done'
