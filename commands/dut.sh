#!/bin/bash

# exit on error
set -e
# log every command
set -x


echo $(pos_get_variable hostname)

# write back some information about the host that might be of interest for the 
# evaluation
pos_set_variable host/kernel-name $(uname -s)
pos_set_variable host/kernel-release $(uname -r)
pos_set_variable host/kernel-version $(uname -v)
pos_set_variable host/os $(uname -o)
pos_set_variable host/machine $(uname -m)

# update apt-get 
apt-get update -y

# install java
DEBIAN_FRONTEND=noninteractive apt-get install default-jre -y

# check if Java is installed
# java --version

# install apache jmeter
JMETER_REPO=$(pos_get_variable jmeter/url)
MQTT_REPO=$(pos_get_variable mqtt-jmeter/url)
GIT_REPO=$(pos_get_variable git/repo)
PLANS_REPO=$(pos_get_variable plans/repo)

DUT=downloads

echo "Downloading JMETER"
wget $JMETER_REPO 

# extract jmeter
tar -xvzf apache-jmeter-5.3.tgz

# move to ext folder 
# cd /lib/ext
# download plugin 
wget $MQTT_REPO

# move plugin to jmeter /lib/ext folder
mv mqtt-xmeter-2.0.2-jar-with-dependencies.jar apache-jmeter-5.3/lib/ext

echo "Cloning $GIT_REPO into $DUT"
git clone --recursive $PLANS_REPO

echo 'all done'
