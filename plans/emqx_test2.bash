#/bin/bash
# Script for resource usages tests of mosquitto sever
# first argument is number of clients
# second argument is port number
local="/media/sf_shared/commands"
a="$1"
b="$2"

sudo time -v timeout 300 emqx foreground 2>> $local/server_results/test2/emqx_$a.txt &

# process for load testing
# jthreads = amount of publishing users
sudo timeout 300 ~/Downloads/apache-jmeter-5.2.1/bin/jmeter -n -t $local/testplans/subComm.jmx -Jthreads=$a -Jport=$b & : 

sleep 350 && kill %!


