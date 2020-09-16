# !/bin/bash

re='^[+-]?[0-9]+$'
re2="^(.+)\/([^/]+)$"
#inputerror="Input error, check your parameters"
exitcode=0

help()
{
    echo "Script Author - Anikeev Fedor M3209";
    echo
    echo "You can use the following commands:"
    echo
    echo "          -calc : allows you to calculate 2 numbers"
    echo "              usage: -sum/sub/mul/div int1 int2"
    echo "              3 and 4th params are numbers (!integers!)"
    echo
    echo "          -search : command does a recurrent search for string with your pattern"
    echo "              usage: -search folderpath pattern"
    echo
    echo "          -reverse : "
    echo "              usage: -reverse -filetoreverse -filewheretostore"
    echo
    echo "          -strlen : calulates length of the string"
    echo "              usage: -stlen -yourstring"
    echo
    echo "          -log: does something..."
    echo
    echo "          -exit: exits programm with your exit code (You can use numbers from 0-244 (default is 0))"
    echo "              usage: -exit yournumber"
    echo
    echo "          -help: prints help"
    echo
    echo "          -interactive: enables interactive mode"
    echo
    echo "          exit codes description:"
    echo "              100 - one of modules was not loaded"
}

whichp=$1
calcsourced=1
searchsourced=1
reversesourced=1
logsourced=1

if [[ "$whichp" = ="-calc" ]]; then # gotta optimize param check for calc
    whichcalc=$2
    num_1=$3
    num_2=$4   
    source calc.sh $whichcalc $num_1 $num_2 2>&- #Here we supress output log...is it bad????
    [[ $? -eq 0 ]] && calcsourced=0 || echo "Source calc.sh is not loaded, ypu can not use -calc command"; exit 100

elif [[ "$whichp" == "-search" ]]; then # hard, need to think
    foldername=$2
    pattern=$3
    source search.sh $foldername $pattern
    [[ $? -eq 0 ]] && searchsourced=0 || echo "Source search.sh is not loaded, you can not use -search command"; exit 100

elif [[ "$whichp" == "-reverse" ]]; then # hard, need to think
    file1=$2
    file2=$3
    source reverse.sh $file1 $file2 2>&-
    [[ $? -eq 0 ]] && reversesourced=0 || echo "Source reverse.sh is not loaded, you can not use -reverse command"; exit 100

elif [[ "$whichp" == "-strlen" ]]; then # Simple enough...
    echo ${#2}
elif [[ "$1" == "-log" ]]; then # lutuiy kek
    source log.sh 2>&-
    [[ $? -eq 0 ]] && logsourced=0 || echo "Source log.sh is not loaded, you can not use -log command"; exit 100

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
elif [[ "$1" == "-help" ]]; then
    help
elif [[ "$1" == "-interactive" ]]; then
    echo "Gachi club welcomes you"    
else    
    echo "There is no such a command, to see available commands please refer to help"
fi