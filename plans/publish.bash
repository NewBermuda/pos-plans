#/bin/bash
# test 1 for mosquitto
# Script for resource usages tests of mosquitto sever
# first argument is port number
# second argument is number of topics to subscribe to
local="/media/sf_shared/commands"
a="$1"

while true
do
	mosquitto_pub -p $1 -t 'test' -m 'hello' &
	sleep 1s 
done
kill %!

