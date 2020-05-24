#/bin/bash
# test 1 for mosquitto
# Script for resource usages tests of mosquitto sever
# first argument is port number
# second argument is number of topics to subscribe to
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


sudo time -v timeout 60 vernemq console -noshell -noinput 2>> $local/server_results/test1/verne_$b.txt &

# process for load testing
# jthreads = amount of publishing users
sleep 10
sudo timeout 60 ~/Downloads/apache-jmeter-5.2.1/bin/jmeter -n -t $local/testplans/csv.jmx -Jport=$a & : 

sleep 75 && kill %!


