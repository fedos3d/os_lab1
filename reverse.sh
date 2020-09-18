# !/bin/bash

#Tasks to do:
#Does not work in interactive mode, gotta fix...
# my command: tac -r -s 'x\|[^x]'

inputfile=$1
outputfile=$2

filereg="^(.+)\/([^\/]+)$"
if [[ -z "$inputfile" ]]; then
    echo "You have not entered input file, please refer to -help command"
elif [[ -z "$outputfile" ]]; then
    echo "You have not entered output file, please refer to -help command"    
elif [[ $inputfile =~ $filereg && $outputfile =~ $filereg ]]; then
    tac -r -s 'x\|[^x]' $inputfile > $outputfile
    [[ $? -eq 1 ]] && echo "There is no such file, pleade refer to help"
    exit 0
else
    echo "You have enterd wrong filename, please refer to help"
    exit 0
fi

