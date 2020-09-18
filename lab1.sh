# !/bin/bash

#Tasks to do:
#Check source onlt once, in the begging of programm and store result in array.
#log command prints only line containing warning and info alias, is it okay?
#interactive search,reverse does not work...
#exit codes need polishing
#help command needs polishing
#overall polising: rewrite if statement in shirt form, bash butifier

whichp=$1 #Var responsible for command

defIFS=$IFS #Remember default IFS

re='^[+-]?[0-9]+$' #regexp for numbers

#source files (in case they are moved)
calcsource="calc.sh"
searchsource="search.sh"
reversesource="reverse.sh"
logsource="log.sh"

#return codes
nomodulecode=100

#messages for user
returnmes="Returning to command list..."
modulenotloaded="Module responsible for this command is not loaded, you can not use this command. "
modulenotloadedinter="$modulenotloaded$returnmes"

#function runs help command
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
    echo "              usage: -reverse filetoreverse filewheretostore"
    echo
    echo "          -strlen : calulates length of the string"
    echo "              usage: -stlen yourstring"
    echo
    echo "          -log: prints log from a specified file (\"/var/log/anaconda/X.log\")"
    echo
    echo "          -exit: exits programm with your exit code (You can use numbers from 0-244 (default is 0))"
    echo "              usage: -exit yournumber"
    echo
    echo "          -help: prints help"
    echo
    echo "          -interactive: enables interactive mode"
    echo
    echo "          exit codes description:"
    echo "              100 - module was not loaded"
    echo "              150 - file was not found"
    echo "              0 - succes"
    echo "              10 - no such command"
}

#function that checks if file ca be loaded
checksource()
{
    file=$1
    [[ -f "$file" ]] && return 0 || return 1 
}

#function that runs calc command
runcalc() 
{
        whichcalc=$1
        num_1=$2
        num_2=$3   
        source $calcsource $whichcalc $num_1 $num_2
}

#function that runs search command
runsearch()
{
    foldername=$1
    pattern=$2
    source $searchsource $foldername $pattern

}

#functions that runs reverse command
runreverse()
{
    file1=$1
    file2=$2
    source $reversesource $file1 $file2
}

#function that runs log command
runlog()
{
    source $logsource
}

#functions that runs exit command
exitt()
{
    if [[ $1 =~ $re ]]; then
        if [[ "$1" -ge "0" && "$1" -le "244" ]]; then #here we check that number is in range 0-244
            exit $1
        else
            exit 0
        fi
    else
        exit 0 
    fi
}

#function that runs strlen command
runstrlen()
{
    echo ${#1} #How does it work?
}

if [[ "$whichp" == "-calc" ]]; then   
    checksource $calcsource
    if [[ $? -eq 0 ]]; then
        runcalc $2 $3 $4
        exitt $?
    else
        echo "$modulenotloaded"
        exitt $nomodulecode
    fi
    

elif [[ "$whichp" == "-search" ]]; then
    checksource $searchsource
    if [[ $? -eq 0 ]]; then
        runsearch $2 $3
        exitt $?
    else
        echo "$modulenotloaded"
        exitt $nomodulecode
    fi
elif [[ "$whichp" == "-reverse" ]]; then 
    checksource $reversesource
    if [[ $? -eq 0 ]]; then
        runreverse $2 $3
        exitt $?
    else
        echo "$modulenotloaded"
        exitt $nomodulecode
    fi
elif [[ "$whichp" == "-strlen" ]]; then 
    runstrlen $2    

elif [[ "$1" == "-log" ]]; then 
    checksource $logsource
    if [[ $? -eq 0 ]]; then
        runlog
        exitt $?
    else
        echo "$modulenotloaded"
        exitt $nomodulecode
    fi
elif [[ "$whichp" == "-exit" ]]; then
    exitt $2

elif [[ "$whichp" == "-help" ]]; then
    help
    exitt $?

elif [[ "$whichp" == "-interactive" ]]; then
    ever=0
    while [ $ever -eq 0 ]  
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
    echo "Enter your command: "
    read uscom
    echo
    if [[ $uscom == "c" || $uscom == "s" || $uscom == "r" || $uscom == "l" || $uscom == "e" || $uscom == "len" || $uscom == "h" ]]; then
        if [[ $uscom == "c" ]]; then
            checksource $calcsource 
            if [[ $? -eq 0 ]]; then
                echo "Please chose an operation and provide 2 numbers to calculate. Example: -sum 1 2"
                echo
                read calcthing
                IFS=' '
                read -ra ADDR <<< "$calcthing"
                runcalc ${ADDR[0]} ${ADDR[1]} ${ADDR[2]}
                echo 
                echo $returnmes
                IFS=$defIFS
            else
                echo $modulenotloadedinter
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
            IFS=$defIFS
            else 
                echo $modulenotloadedinter
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
            IFS=$defIFS
            else
                echo $modulenotloadedinter
            fi
        elif [[ $uscom == "l" ]]; then
            checksource $logsource
            if [[ $? -eq 0 ]]; then
            echo "You entered log mode. Printing log..."
            runlog
            echo
            echo $returnmes
            else
                echo $modulenotloadedinter
            fi
        elif [[ $uscom == "e" ]]; then
            echo "You are exiting the program. Enter exit code or do not print anything and exit code will be default(0):"
            read code
            echo
            exitt $code
        elif [[ $uscom == "len" ]]; then
            echo "You entered strlen mode. Please enter a string to get its length"
            read lenstr
            runstrlen $lenstr
            echo 
            echo $returnmes       
        elif [[ $uscom == "h" ]]; then
            echo "You entered help."
            help
            echo
            echo $returnmes
        fi
    else
        echo
        echo "You entered nonvalid command, please refer -help command"
    fi
    done
elif [[ -z "$whichp" ]]; then
    echo "You have not provided any arguments, please refer to -help command"
else    
    echo "There is no such a command, to see available commands please refer to -help command"
fi