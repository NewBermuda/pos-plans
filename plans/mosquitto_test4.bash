#/bin/bash
# Script for resource usages tests of mosquitto sever
# first argument is number of PUBLISH messages per second
# second argument is port number
local="/media/sf_shared/commands"
a="$1"
b="$2"

sudo time -v mosquitto -d -v -p 1884 
mypid=$(sudo pidof mosquitto)
echo $mypid
sudo pidstat -h -r -u -v -p "$mypid" 5 > $local/server_results/test4/mosquitto_$a.txt &
sudo timeout 60 ./publish.bash 1884 &

# process for load testing
# jthreads = amount of publishing users
until sudo ~/Downloads/apache-jmeter-5.2.1/bin/jmeter -n -t $local/testplans/test4.jmx -Jthreads=$a -Jport=$b -j $local/server_results/test4/jlog.log | grep -m 1 "... end of run"; do : ; done
echo $(ps -o pcpu,pmem,rssize -p "$mypid") >>  $local/server_results/test4/mosquitt_PS_$a.txt
sudo kill -9 $mypid
kill %!
