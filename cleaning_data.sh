#!/bin/bash
#check if there is file argument
if [ $# -lt 1 ];then
 echo "Erorr:Missing Argument";
 exit 1
fi
#saving the file in a varible called "input"
input="$1"

#check now if the file exist
if [ ! -f "$input" ];then
 echo "file $input does not exist";
 exit 1
fi
output="cleand_patients.csv" #file that stores cleand data
#using awk to check the line it keeps the header and no empty fields ,NR==1 represnt the header 
awk -F ',' 'NR==1 || ($1 != "" && $2 != "" && $3 != "" && $4 != "")' "$input" > "$output"

