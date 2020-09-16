#!/bin/bash
echo "Hostname of this machine is $HOSTNAME"
echo "Total number of lines in $1 is $(wc -l $1 | awk '{print $1}')"
