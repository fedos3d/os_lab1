# !/bin/bash

#Tasks to do:
#Not working in interactive mode...

foldername=$1
pattern=$2
searcherror="You have entered wrong folder path, please check folder path format using -help command"

path="^(.+)\/([^\/]+)$"
if [ -z "$foldername" ]; then
    echo "You have entered empty foldername"
elif [ -z "$pattern" ]; then
    echo "You have entered empty pattern"
else
    if [[ $foldername =~ $path ]]; then
        grep -r $pattern $foldername 2>&-
        [[ $? -eq 1 ]] && echo "There are no strings matching your pattern"
        [[ $? -eq 2 ]] && echo "No such folder"
    else
        echo $searcherror #can I use grep here?
        
    fi
fi