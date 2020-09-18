# !/bin/bash

inputfile=$1
outputfile=$2

filereg="^(.+)\/([^\/]+)$"

if [[ -z "$inputfile" ]]; then
    echo "You have not entered input file, please refer to -help command"
    return 35
elif [[ -z "$outputfile" ]]; then
    echo "You have not entered output file, please refer to -help command"   
    return 35
elif [[ $inputfile =~ $filereg && $outputfile =~ $filereg ]]; then
    tac -r -s 'x\|[^x]' 2>&- $inputfile > $outputfile 2>&-
    [[ $? -eq 0 ]] && return 0
    [[ $? -eq 1 ]] && echo "Check your paramets (input and output file), please refer to -help command"; return 150
    #[[ $? -eq 2 ]] && echo "No such folder"
else
    echo "You have enterd wrong filepath, please refer to -help command"
    return 150
fi

