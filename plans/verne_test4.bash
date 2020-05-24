#/bin/bash
# Script for resource usages tests of mosquitto sever
# first argument is number of threads
# second argument is port number of server to be load tested
local="/media/sf_shared/commands"
a="$1"
b="$2"

sudo vernemq stop
sleep 5
sudo vernemq start
sleep 10 
mypid=$(sudo vernemq getpid)
echo $mypid
sudo pidstat -h -r -u -v -p "$mypid" 5 > $local/server_results/test4/verneqmx_stats$a.txt &
sudo timeout 60 ./publish.bash 1886 &

# process for load testing
# jthreads = amount of publishing users
sleep 13
until sudo ~/Downloads/apache-jmeter-5.2.1/bin/jmeter -n -t $local/testplans/test4.jmx -Jthreads=$a -Jport=$b | grep -m 1 "... end of run"; do : ; done
echo $(ps -o pcpu,pmem,rssize -p "$mypid") >> $local/server_results/test4/verne_ps_$a.txt
sudo vernemq stop
kill %!