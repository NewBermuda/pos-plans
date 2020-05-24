#/bin/bash
# test 1 for mosquitto
# Script for resource usages tests of mosquitto sever
# first argument is number of clients
# second argument is port number
local="/media/sf_shared/commands"
a="$1"
b="$2"
killall -9 java
sudo ~/Downloads/hivemq-ce-2020.2/bin/run.sh 2>> $local/server_results/test2/hivemq_$a.txt &
mypid=$(sudo pidof java)
echo $mypid
sudo pidstat -h -r -u -v -p "$mypid" 5 > $local/server_results/test2/hivemq_$b.txt &

# process for load testing
# jthreads = amount of publishing users
sleep 20 
until sudo ~/Downloads/apache-jmeter-5.2.1/bin/jmeter -n -t $local/testplans/subComm.jmx -Jthreads=$a -Jport=$b | grep -m 1 "... end of run"; do : ; done
echo $(ps -o pcpu,pmem,rssize -p "$mypid") >> $local/server_results/test2/hive_$a.txt
killall -9 java
kill %!