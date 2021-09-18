
$#    Stores the number of command-line arguments that 
      were passed to the shell program.
$?    Stores the exit value of the last command that was 
      executed.
$0    Stores the first word of the entered command (the 
      name of the shell program).
$*    Stores all the arguments that were entered on the
      command line ($1 $2 ...).
"$@"  Stores all the arguments that were entered
      on the command line, individually quoted ("$1" "$2" ...).

var=$((var+1))
((var=var+1))
((var+=1))
((var++))

root@DESKTOP-2I5IOB1:~# while [[ $myvar -lt 6 ]]; do if [[ -f /tmp/file$myvar ]]; then echo "File Exists"; else touch /tmp/file$myvar; fi; (( myvar++ )); done


#!/bin/bash
read -p "Enter The Number:" NUM
if [[ $NUM == "" ]]
then
echo "Enter Valid Number."
else
if [[ $(($NUM % 2))  -eq 0 ]]
then
echo "EVEN"
else
echo "ODD"
fi
Fi

https://www.tldp.org/LDP/abs/html/opprecedence.html
