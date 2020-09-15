# !/bin/bash

#Rewrtie using bc |

inputnumbererror="Input error, check your parameters"
whichcalc=$1
num_1=$2
num_2=$3
re="^[+-]?[0-9]+$"

no_such_calc_command() {
    echo "There is no such a calc command, please refer to the help"
}

sum() {
    sum=$(($num_1 + $num_2))     
    echo $sum    
}

sub() {
    sub=$(($num_1 - $num_2))
    echo $sub
}
mul() {
    mul=$(($num_1 * $num_2))
    echo $mul
}
div() {
    if [[ $num_2 = 0 ]]; then #Here we check if second param is not zero
        echo "Input error, You can't divide by zero"
    else
        echo "$num_1 / $num_2" | bc -l
    fi    
    
}
if [[ $num_1 =~ $re  &&  $num_2 =~ $re ]]; then #Here we check if params are numbers
    case $whichcalc in
        sum)
            sum
            ;;
        sub)
            sub
            ;;
        mul)
            mul
            ;;
        div)
            div
            ;; 
        *)
        no_such_calc_command
        ;;
        esac       
else
    echo $inputnumbererror        
fi