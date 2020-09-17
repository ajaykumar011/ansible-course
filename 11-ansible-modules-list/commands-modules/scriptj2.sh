#!/bin/bash
echo "Hostname of this machine is $HOSTNAME"
echo $(date) > /etc/motd
sleep 2