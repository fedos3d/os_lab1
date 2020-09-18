# !/bin/bash


logfile="X.log"
warningreg="(WW)"
informationreg="(II)"
excetion1="(EE)"
exception2="(!!)"

yellow='\033[1;33m'
blue='\033[1;34m'

mem=$IFS

IFS=$'\n'  
for line in $(cat $logfile)    
do
    if [[ $line =~ $warningreg && ! $line =~ $excetion1 ]]; then
    echo -e "${yellow}$line"
fi
done

IFS=$'\n'  

for line in $(cat $logfile) 
do
if [[ $line =~ $informationreg && ! $line =~ $exception2 ]]; then
    echo -e "${blue}$line"
fi
done