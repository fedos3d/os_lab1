# !/bin/bash

# WW - warning
# II - Infromation

logfile="/var/log/anaconda/X.log"
warningreg="(II)"

for log in $logfile
do
egrep "$warningreg" $log
done