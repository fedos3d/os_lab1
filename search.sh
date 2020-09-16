# !/bin/bash


foldername=$1
pattern=$2
searcherror="You have entered wrong folder path or pattern, please check folder path format using help command"

path="^(.+)\/([^\/]+)$"
if [ -z "$pattern" ]; then
    echo "You have entered empty pattern"
else
    if [[ $foldername =~ $path ]]; then
        grep -r $pattern $foldername 2>&-
        [[ $? -eq 2 ]] && echo "No such folder"
        [[ $? -eq 1 ]] && echo "There are no strings matching your pattern"
        
    else
        echo $searcherror #can I use grep here?
        
    fi
fi