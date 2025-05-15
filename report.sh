#!/bin/bash
#check if the file name passed
if [ $# -ne 1 ]; then
  echo "Enter the file name as argument"
  exit 1
fi

input_file=$1
output_file="top_doctors_report.txt"

#write the report
{ 	echo "  Top 5 Doctors Report" 
	echo " =======================" 
	echo " Num_patients, Doctor_name"
} >"$output_file"

# Extract the 6th column (skip the header)
awk -F',' ' NR >1 {print $6}' "$input_file" | sort | uniq -c | sort -nr | head -n 5 | \
awk '{print "", $1,  "          , "  $2, $3}' >>"$output_file"

#Inform the user that the report is done
echo "The report has been created in $output_file"

