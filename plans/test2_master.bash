#/bin/bash
# Script for resource usages tests of mqtt.js
# first argument is number of threas
for i in {0..3000..500}
do
	/media/sf_shared/commands/mosquitto_test2.bash $i 1884
	/media/sf_shared/commands/hivemq_test2.bash $i 1883
	/media/sf_shared/commands/emqx_test2_pid.bash $i 1885
	/media/sf_shared/commands/verne_test2_pid.bash $i 1886
done

