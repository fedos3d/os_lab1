# !/bin/bash

re='^[+-]?[0-9]+$'
re2="^(.+)\/([^/]+)$"
returnmes="Returning to command list..."
#inputerror="Input error, check your parameters"
exitcode=0

calcsource="calc.sh"
searchsource="search.sh"
reversesource="reverse.sh"
logsource="log.sh"

modulenotloaded="Module responsible for this command is not loaded, you can not use this command. $returnmes"


help() #Need to work on
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

checksource()
{
    file=$1
    [[ -f "$file" ]] && return 0 || return 1 
}

runcalc() 
{
        calcsourced=0
        whichcalc=$1
        num_1=$2
        num_2=$3   
        source calc.sh $whichcalc $num_1 $num_2
        #source calc.sh $whichcalc $num_1 $num_2 2>&- #Here we supress output log...is it bad????
        #[[ $? -eq 0 ]] && calcsourced=0 || echo "Source calc.sh is not loaded, ypu can not use -calc command"; 
}

runsearch()
{
    foldername=$1
    pattern=$2
    source search.sh $foldername $pattern
    [[ $? -eq 0 ]] && searchsourced=0 || echo "Source search.sh is not loaded, you can not use -search command"; 

}

runreverse()
{
    file1=$1
    file2=$2
    source reverse.sh $file1 $file2 2>&-
    [[ $? -eq 0 ]] && reversesourced=0 || echo "Source reverse.sh is not loaded, you can not use -reverse command";
}

runlog()
{
    echo "Log command is not yet available"
    #source log.sh 2>&-
    #[[ $? -eq 0 ]] && logsourced=0 || echo "Source log.sh is not loaded, you can not use -log command"; exit 100
}

exitt()
{
    if [[ $1 =~ $re ]]; then
        if [[ "$1" -ge "0" && "$1" -le "244" ]]; then
            exit $1
        else
            exit 0
        fi
    else
        exit 0 
    fi
}

runstrlen()
{
    echo ${#1}
}

if [[ "$whichp" = ="-calc" ]]; then # gotta optimize param check for calc   
    runcalc $2 $3 $4

elif [[ "$whichp" == "-search" ]]; then # hard, need to think
    runsearch $2 $3

elif [[ "$whichp" == "-reverse" ]]; then # hard, need to think
    runreverse $2 $3

elif [[ "$whichp" == "-strlen" ]]; then # Simple enough...
    runstrlen $2    

elif [[ "$1" == "-log" ]]; then # lutuiy kek
    runlog

elif [[ "$whichp" == "exit" ]]; then
    exitt $2

elif [[ "$whichp" == "-help" ]]; then
    help

elif [[ "$whichp" == "-interactive" ]]; then
    ever=0
    while [ 0 ]  
    do
    echo
    echo "You are now in interactive mode!"
    echo
    echo "Please enter a letter to run a command: "
    echo "c - starts calulator"
    echo "s - starts search"
    echo "h - starts help"
    echo "r - starts reverse"
    echo "len - starts strlen"
    echo "l - starts log"
    echo "e - promts you to enter exit code and finish program"
    echo 
    echo "Enter your command: "
    read uscom
    if [[ $uscom == "c" || $uscom == "s" || $uscom == "r" || $uscom == "l" || $uscom == "e" || $uscom == "len" || $uscom == "h" ]]; then
        if [[ $uscom == "c" ]]; then
            checksource $calcsource 
            if [[ $? -eq 0 ]]; then
                echo "Please chose an operation and provide 2 numbers to calculate. Example: sum 1 2"
                echo
                read calcthing
                IFS=' '
                read -ra ADDR <<< "$calcthing"
                runcalc ${ADDR[0]} ${ADDR[1]} ${ADDR[2]}
                echo 
                echo $returnmes
                echo
            else
                echo $modulenotloaded
            fi
        elif [[ $uscom == "s" ]]; then
            checksource $searchsource
            if [[ $? -eq 0 ]]; then
            echo "You entered search mode, please enter foldename and pattern"
            read searchthing
            IFS=' '
            read -ra ADDR <<< "$searchthing"
            runsearch ${ADDR[0]} ${ADDR[1]}
            echo
            echo $returnmes
            echo
            else 
                echo $modulenotloaded
            fi
        elif [[ $uscom == "r" ]]; then
            checksource $reversesource
            if [[ $? -eq 0 ]]; then
            echo "You entered reverse mode. Please enter input file and output file. Example input.txt output.txt"
            read reversething
            IFS=' '
            read -ra ADDR <<< "$reversething"
            runreverse ${ADDR[0]} ${ADDR[1]}
            echo
            echo $returnmes
            echo
            else
                echo $modulenotloaded 
            fi
        elif [[ $uscom == "l" ]]; then
            checksource $logsource
            if [[ $? -eq 0 ]]; then
            echo "You entered log mode. Log is to be printed"
            runlog
            echo
            echo $returnmes
            echo
            else
                echo $modulenotloaded
            fi
        elif [[ $uscom == "e" ]]; then
            echo "You are exiting the program. Enter exit code or do not print anything and exit code will be default(0)"
            read code
            echo
            exitt $code
        elif [[ $uscom == "len" ]]; then
            echo "You entered strlen mode. Please enter a string to get its length"
            read lenstr
            runstrlen $lenstr
            echo 
            echo $returnmes
            echo          
        elif [[ $uscom == "h" ]]; then
            echo "You entered help."
            help
            echo
            echo $returnmes
            echo  
        fi
    else
        echo
        echo "You entered nonvalid command, please refer to command list for more"
    fi
    done
else    
    echo "There is no such a command, to see available commands please refer to help"
fi