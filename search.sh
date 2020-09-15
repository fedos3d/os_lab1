# !/bin/bash


foldername=$1
pattern=$2
searcherror="You have entered wrong folder path or patter, please check folder path format using help command"

path="^(.+)\/([^\/]+)$"

[[ $foldername =~ $path ]] && grep -r $pattern $foldername || echo $searcherror