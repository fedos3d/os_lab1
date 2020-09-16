# !/bin/bash

#Do i need here functions? or i can rewrite calc.sh without functions, because they are litterly just one string.

whichcalc=$1
num_1=$2
num_2=$3

inputnumbererror="Input error, your parameters are not numbers, please refer to help"
nosuchcalccommand="There is no such a calc command, please refer to the help"

re="^[+-]?[0-9]+$"


sum() {     
    echo "$num_1 + $num_2" | bc
}

sub() {
    echo "$num_1 - $num_2" | bc
}
mul() {
    echo "$num_1 * $num_2" | bc
}
div() {
    if [[ $num_2 = 0 ]]; then #Here we check if second param is not zero
        echo "Input error, You can't divide by zero"
    else
        echo "$num_1 / $num_2" | bc -l | perl -pe '/\./ && s/0+$/$1/ && s/\.$//' #Is it okay that i used perl there?
    fi    
    
}
if [[ "$whichcalc" = "sum" || "$whichcalc" = "sub" || "$whichcalc" = "mul" || "$whichcalc" = "div" ]]; then
    if [[ -z "$num_1" || -z "$num_2" ]]; then
            echo "One or both of your numbers are empty strings, please refer to help for more infomation"
    elif [[ $num_1 =~ $re  &&  $num_2 =~ $re ]]; then #Here we check if params are numbers
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
            esac
    
    else
        echo $inputnumbererror
    fi       
else
    echo $nosuchcalccommand      
fi