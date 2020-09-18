# !/bin/bash

foldername=$1
pattern=$2
searcherror="You have entered wrong folder path, please check folder path format using -help command"

path="^(.+)\/([^\/]+)$"

if [[ -z "$foldername" ]]; then
    echo "You have entered empty foldername"
    return 35
elif [[ -z "$pattern" ]]; then
    echo "You have entered empty pattern"
    return 35
else
    if [[ $foldername =~ $path ]]; then
        grep -r "$pattern" "$foldername" 2>&-
        case $? in
            0)
                return 0
                ;;
            1)
                echo "There are no strings matching your pattern"; return 25
                ;;
            2)
                echo "No such folder"; return 150
                ;;
        esac
    else
        echo $searcherror
        return 150
    fi
fi