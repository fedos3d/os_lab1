# !/bin/bash

#Need to add code which can show more then oneline string?????
#excludereg="((\+\+)|(\!\!)|(\-\-)|(\*\*)|(\=\=)|(EE)|(NI)|(\?\?))$"

logfile="X.log"
warningreg="(WW)"
informationreg="(II)"
excetion1="(EE)"
exception2="(!!)"

yellow='\033[1;33m' #Yellow color
blue='\033[1;34m' #Blue color

mem=$IFS #Store default IFS value

IFS=$'\n' 

if [[ -f "$logfile" ]]; then 

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
NC='\033[0m' #No color
echo -e "$NC"
IFS=$mem
return 0
else
    echo "Log file was not found"
    return 150
fi