#/bin/bash
# Script for resource usages tests of mqtt.js
# first argument is number of threas
for i in {10..100..10}
do
	/home/melvin/Desktop/windowsshare/commands/jsbash_parameter.bash $i
	/home/melvin/Desktop/windowsshare/commands/mosquittosub_parameter.bash $i
done

