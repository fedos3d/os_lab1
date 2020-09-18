# !/bin/bash

whichcalc=$1
num_1=$2
num_2=$3

inputnumbererror="Input error, one or both parameters you have provided are not numbers or numbers with plus sign, please refer to -help command"
nosuchcalccommand="There is no such a calc command, please refer to the -help command"

re="^[-]?[0-9]+$" #regex for numbers

sum() {     
    echo "$num_1 + $num_2" | bc 2>&-
    return 0
}

sub() {
    echo "$num_1 - $num_2" | bc 2>&-
    return 0
}

mul() {
    echo "$num_1 * $num_2" | bc 2>&-
    return 0
}

div() {
    if [[ $num_2 = 0 || $num_2 == "-0" || $num_2 == "+0" ]]; then #Here we check if second param is not zero
        echo "Input error, You can't divide by zero"
        return 19
    else
        echo "$num_1 / $num_2" | bc -l | perl -pe '/\./ && s/0+$/$1/ && s/\.$//' 2>&-
        return 0
    fi    
}

if [[ "$whichcalc" == "-sum" || "$whichcalc" == "-sub" || "$whichcalc" == "-mul" || "$whichcalc" == "-div" ]]; then
    if [[ -z "$num_1" || -z "$num_2" ]]; then
            echo "You have not provided one or both numbers required for calculation, please refer to -help command"
            return 35
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
        return 18
    fi       
elif [[ -z "$whichcalc" ]]; then
    echo "You have not provided any calc command, please refer to -help command"
    return 35
else
    echo $nosuchcalccommand
    return 15
fi