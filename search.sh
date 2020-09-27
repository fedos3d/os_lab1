# !/bin/bash

#Search needs work

foldername=$1
pattern=$2
searcherror="You have entered wrong folder path, please check folder path format using -help command"

path1="((?:[^/]*/)*)(.*)$"

if [[ -z ${1+x} ]]; then
    echo "You have entered no foldername, please refer to -help command"
    return 35
elif [[ -z ${2+x} ]]; then
    echo "You have entered no pattern, please refer to -help command"
    return 35
else
    if [[ $foldername =~ $path1 || $foldername =~ $path2 ]]; then
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