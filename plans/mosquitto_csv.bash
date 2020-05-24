#/bin/bash
# test 1 for mosquitto
# Script for resource usages tests of mosquitto sever
# first argument is port number
# second argument is number of threads to subscribe to
local="/media/sf_shared/commands"
a="$1"
b="$2"
topics="" 

# create list of topics
for i in $(seq 1 $2); 
do
	topics=$topics$i","
done 
topics=${topics::-1}
echo "\""$topics""\" > $local/testplans/topics.txt

sudo time -v timeout 30 mosquitto -v -p 1884 2>> $local/server_results/test1/mosquitto_$b.txt &

# process for load testing
# jthreads = amount of publishing users
sleep 5
sudo timeout 30 ~/Downloads/apache-jmeter-5.2.1/bin/jmeter -n -t $local/testplans/csv.jmx -Jport=$a & : 

sleep 35 && kill %!


