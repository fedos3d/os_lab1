# !/bin/bash

re='^[+-]?[0-9]+$'
re2="^(.+)\/([^/]+)$"
#inputerror="Input error, check your parameters"
exitcode=0

help()
{
    echo "Script Author - Anikeev Fedor M3209";
    echo;
    echo "Need to zapolnuty";
    echo "You can use the following commands:"
    echo "-calc : allows you to calculate 2 numbers"
    echo "       usage: -sum/sub/mul/div int1 int2"
    echo "            3 and 4th params are numbers (!integers)"
    echo "-search : command does a recurrent search for string with your pattern"
    echo "       usage: -search -folderpath -pattern"
    echo "-reverse : "
    echo "       usage: -reverse -filetoreverse -filewheretostore"
    echo "-strlen : calulates length of the string"
    echo "       usage: -stlen -yourstring"
    echo "-log: does something..."
    echo "-exit: exits programm with your exit code (You can use numbers from 0-244 (default is 0))"
    echo "       usage: -exit yournumber"
    echo "-help: prints help"
    echo "-interactive: enables interactive mode"
    echo;
    echo "exit codes description:"
    echo "        100 - one of modules was not loaded"
}

whichp=$1
calcsourced=1
searchsourced=1

if [[ "$whichp" == "calc" ]]; then # gotta optimize param check for calc
    whichcalc=$2
    num_1=$3
    num_2=$4   
    source calc.sh $whichcalc $num_1 $num_2 2>&- #Here we supress output log...is it bad????
    [[ $? -eq 0 ]] && calcsourced=0 || echo "Source isnot laoded succefully"; exit 100
elif [[ "$whichp" == "search" ]]; then # hard, need to think
    foldername=$2
    pattern=$3
    source search.sh $foldername $pattern
    [[ $? -eq 0 ]] && searchsourced=0 || echo "Source search.sh is not loaded"; exit 100
elif [[ "$1" == "reverse" ]]; then # hard, need to think
    if [[ $2 =~ $re2 ]]; then
        if [[ $3 =~ $re2 ]]; then
            echo "Мину жеппа"
        fi
    fi        
elif [[ "$whichp" == "strlen" ]]; then # Simple enough...
    echo ${#2}
elif [[ "$1" == "log" ]]; then # lutuiy kek
    echo "Ne nu a cho..."
elif [[ "$whichp" == "exit" ]]; then
    if [[ $2 =~ $re ]]; then
        if [[ "$2" -ge "0" && "$2" -le "244" ]]; then
            exit $2
        else
            exit 0
        fi
    else
        exit 0 
    fi
elif [[ "$1" == "help" ]]; then
    echo help
elif [[ "$1" == "interactive" ]]; then
    echo "Gachi club welcomes you"    
else    
    echo "Koshi takogo ne govoril"
fi