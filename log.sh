# !/bin/bash

#Need to add code which can show more then oneline string?????


logfile="/var/log/anaconda/X.log"
warningreg="(WW)"
informationreg="(II)"
excetion1="(EE)"
exception2="(!!)"

yellow='\033[1;33m' #Yellow color
blue='\033[1;34m' #Blue color
NC='\033[0m' #No color

mem=$IFS #Store default IFS value

IFS=$'\n' 

if [[ -f "$logfile" ]]; then 
    for line in $(cat $logfile); do
        [[ $line =~ $warningreg && ! $line =~ $excetion1 ]] && echo -e "${line//(WW)/${yellow}Warning:${NC}}"
    done

    IFS=$'\n'  

    for line in $(cat $logfile); do
        [[ $line =~ $informationreg && ! $line =~ $exception2 ]] && echo -e "${line//(II)/${blue}Infromation:${NC}}"
    done

    
    echo -e "$NC"
    IFS=$mem
    
    return 0
else
    echo "Log file was not found"
    return 150
fi