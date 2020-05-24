#/bin/bash
# Script for resource usages tests of mqtt.js

sudo time -v timeout 30 mqtt sub -t 'test' -h '127.0.0.1' -v 2> outputmqtt.txt &

# process for load testing
# jthreads = amount of publishing users
sudo timeout 30 ./jmeter -n -t pubComm.jmx -Jthreads=10 & : 

sleep 35 && kill %!


