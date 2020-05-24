#!/bin/bash

# Setup of a simple experiment with two hosts involved.
#
# The hosts are allocated, rebooted, and the experiment scripts are deployed to the experiment
# hosts. The two experiment scripts demonstrate how to use all of the $POStools on the hosts.
# The experiment is to run one of the example MoonGen scripts

if test "$#" -ne 2; then
	echo "Usage: setup.sh loadgen dut"
	exit
fi

set -x
LOADGEN=$1
DUT=$2

DIR=$(dirname $(realpath $0))
POS=pos

# in the best case, the hosts are already free
echo "free hosts"
# calendar not enforced: force freeing
#$POS allocations free --force "$LOADGEN"
#$POS allocations free --force "$DUT"
#calendar enforced: free only if you have a valid calendar entry (force not available)
$POS allocations free "$LOADGEN"
$POS allocations free "$DUT"

# allocate all hosts for ONE experiment
# if calendar is enforced this can only be done if you have a valid calendar entry at the moment
# automatically create entry with '--duration' flag
echo "allocate hosts"
$POS allocations allocate "$LOADGEN" "$DUT"

echo "load experiment variables"
$POS allocations variables "$LOADGEN" $DIR/variables/loadgen.yml
$POS allocations variables "$DUT" $DIR/variables/dut.yml
$POS allocations variables "$LOADGEN" --as-global $DIR/variables/global.yml

echo "set images to debian stretch"
$POS nodes image "$LOADGEN" debian-stretch
$POS nodes image "$DUT" debian-stretch

echo "reboot experiment hosts..."
# run reset blocking in background
$POS nodes reset "$LOADGEN" --non-blocking
$POS nodes reset "$DUT" --non-blocking

echo "deploy & run experiment scripts..."
# Queue up the commands. They will be executed once booting is done
# Capture the returned command ID of one command to wait for it finish
COMMAND_LOADGEN_ID=$($POS commands launch --infile $DIR/commands/loadgen.sh "$LOADGEN" --queued --name loadgen)

echo "waiting for loadgen to finish"
$POS commands await $COMMAND_LOADGEN_ID

$POS nodes bootstrap "$DUT"

COMMAND_DUT_ID=$($POS commands launch --infile $DIR/commands/dut.sh "$DUT" --queued --name dut)

echo "waiting for dut to finish"
$POS commands await $COMMAND_DUT_ID

echo 'finished setting up two nodes'
