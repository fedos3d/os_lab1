# !/bin/bash

# WW - warning
# II - Infromation

#didn't get yet how to download file to centos

logfile="/var/log/anaconda/X.log"
warningreg="(II)"

for log in $logfile
do
egrep "$warningreg" $log
done