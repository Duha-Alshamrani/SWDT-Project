#!/bin/bash

# Check if there is file argument
if [ $# -lt 1 ];then
  echo "Error: Missing argument"
  exit 1
fi

path="$1"

# Define the required columns
requiredColumns=("Name" "ID" "AdmissionDate" "DischargeDate" "Disease"
"Doctor")

# Get the header
header=$(awk 'NR==1 {print $0}' "$path")

# Initialize (0: default value, no columns are missing)
missingColumns=0

# Loop through each required column
for col in $requiredColumns; 
do
   # Check if the column exists (using grep to search for the column name)
   # -i: ignore case distinctions
   # -o: output the matching part (column name)
   if ! echo "$header" | grep -i -o "$col" > /dev/null; 
   then
       echo "Missing column: $col"
       missingColumns=1
   fi
done

# If any columns are missing, stop the script
if [ $missingColumns -eq 1 ]; then
   echo "The file is missing required column."
   exit 1
else
   echo "All required columns are present."
fi
