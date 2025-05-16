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
output="patient_stay_Durations.txt" #save the output of this coade in a text file
echo -e "\n---------Patient Stay Durations---------\n" > "$output" # -e is option allows tabs and new line used in here for orgnized output and then appended to the output file
echo -e "Name\t\tID\tAdmission date\tDischarge date\tstay duration (days)" >> "$output" #append to the output file without replacing the content (also applied in line 18
echo -e "----\t\t---\t--------------\t--------------\t-------------------" >> "$output"
#here used awk to skip the first line of csv file
#then it will pass each line "using pipe" to while loop where it reads values
#IFS here helps read command  to split each line by comma to 4 parts
awk -F, 'NR > 1 {print $1"," $2"," $3"," $4}' "$input" | while IFS=',' read -r name id in out
do
 #here convert the dates into seconds to calculate the duration
 inS=$(date -d "$in" +%s) #converting the admission date
 outS=$(date -d "$out" +%s) #converting the discharge date
 duration=$(( (outS - inS) / 86400 )) #here subtarcting to get the duration then dividing by "86400" to convert from seconds to days 
  echo -e "$name\t$id\t$in\t$out\t$duration" >> $output #lastly add the output of each line into the final file
done
