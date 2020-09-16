# !/bin/bash

# WW - warning yellow
# II - Infromation blue

#didn't get yet how to download file to centos

logfile="/var/log/anaconda/X.log"
warningreg="(WW)"
informationreg="(II)"

for log in $logfile
do
GREP_COLOR='1;33' egrep --color=always "$warningreg" $log
done

for log in $logfile
do
GREP_COLOR='0;34' egrep --color=always "$informationreg" $log
done