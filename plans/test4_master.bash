#/bin/bash
# Script for resource usages tests of mqtt.js
# first argument is number of threas
for i in {1000..5000..1000}
do
	/media/sf_shared/commands/mosquitto_test4.bash $i 1884
	/media/sf_shared/commands/hivemq_test4.bash $i 1883
	/media/sf_shared/commands/emqx_test4.bash $i 1885
	/media/sf_shared/commands/verne_test4.bash $i 1886
done

