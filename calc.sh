# !/bin/bash

#Do i need here functions? or i can rewrite calc.sh without functions, because they are litterly just one string.

#Tasks to do:
#Polish file and params check

whichcalc=$1
num_1=$2
num_2=$3

inputnumbererror="Input error, one or both parameters you have provided are not numbers, please refer to -help command"
nosuchcalccommand="There is no such a calc command, please refer to the -help command"

re="^[+-]?[0-9]+$" #regex for numbers

command_success()
{
    [[ ! $1 -eq 0 ]] && echo "Input error, check your params, refer to the -help command"
}

sum() {     
    echo "$num_1 + $num_2" | bc 2>&-
    command_success $?
}

sub() {
    echo "$num_1 - $num_2" | bc 2>&-
    command_success $?
}
mul() {
    echo "$num_1 * $num_2" | bc 2>&-
    command_success $?
}
div() {
    if [[ $num_2 = 0 || $num_2 == "-0" || $num_2 == "+0" ]]; then #Here we check if second param is not zero
        echo "Input error, You can't divide by zero"
    else
        echo "$num_1 / $num_2" | bc -l | perl -pe '/\./ && s/0+$/$1/ && s/\.$//' 2>&-
    fi    
    
}
if [[ "$whichcalc" == "-sum" || "$whichcalc" == "-sub" || "$whichcalc" == "-mul" || "$whichcalc" == "-div" ]]; then
    if [[ -z "$num_1" || -z "$num_2" ]]; then
            echo "You have not provided one or both numbers required for calculation, please refer to -help command"
    elif [[ $num_1 =~ $re  &&  $num_2 =~ $re ]]; then #Here we check if params are numbers
            case $whichcalc in
                -sum)
                    sum
                    ;;
                -sub)
                    sub
                    ;;
                -mul)
                    mul
                    ;;
                -div)
                    div
                    ;; 
            esac
    
    else
        echo $inputnumbererror
    fi       
elif [[ -z "$whichcalc" ]]; then
    echo "You have not provided any calc command, please refer to -help command"
else
    echo $nosuchcalccommand      
fi