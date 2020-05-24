#/bin/bash
# Script for resource usages tests of mqtt.js
# first argument is number of threas
for i in {10000..50000..10000}
do
 	/media/sf_shared/commands/mosquitto_test1.bash 1884 $i
	/media/sf_shared/commands/hivemq_test1.bash 1883 $i
	/media/sf_shared/commands/emqx_test1_stats.bash 1885 $i
	/media/sf_shared/commands/verne_test1_pid.bash 1886 $i
done

