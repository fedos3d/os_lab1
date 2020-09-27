# !/bin/bash

inputfile=$1
outputfile=$2

filereg="(?:[^/]*/)*)(.*)$"

if [[ -z "$inputfile" ]]; then
    echo "You have not entered input file, please refer to help command"
   return 35
elif [[ -z "$outputfile" ]]; then
    echo "You have not entered output file, please refer to help command"   
    return 35
fi
if [[ -f "$inputfile" ]]; then
    tac -r -s 'x\|[^x]' 2>&- $inputfile > $outputfile 2>&-
    case $? in
        0)
            return 0
            ;;
        1)
            echo "Check your paramets (input and output file), please refer to help command"; return 150
            ;;
        2)
            echo "No such file"; return 150
            ;;
    esac
else
        echo "Input file does not exist"
    return 35
fi