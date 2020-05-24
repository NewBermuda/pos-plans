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

sudo emqx stop
sleep 5
sudo emqx start
sleep 10 
mypid=$(sudo emqx pid)
echo $mypid
sudo pidstat -h -r -u -v -p "$mypid" 5 > $local/server_results/test1/emqx_$b.txt &

# process for load testing
# jthreads = amount of publishing users
sleep 5
until sudo ~/Downloads/apache-jmeter-5.2.1/bin/jmeter -n -t $local/testplans/csv.jmx -Jport=$a | grep -m 1 "... end of run"; do : ; done 
echo $(ps -o pcpu,pmem,rssize -p "$mypid") >> $local/server_results/test1/emqx_ps_$b.txt
sudo emqx stop
kill %!

