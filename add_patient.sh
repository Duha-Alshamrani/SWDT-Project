#!/bin/bash

# Check if there is file argument
if [ $# -lt 1 ];
then
  echo "Error: Missing argument"
  exit 1
fi

path="$1"

# Ask user 
read -p "Do you want to add a new patient? (Y/N): " answer

if [[ "$answer" == "Y" ]];
then
    echo "Enter the patient information:"
    read -p "Name: " Name
    read -p "ID: " ID
    read -p "Admission Date (M/D/YYYY): " Admission
    read -p "Discharge Date (M/D/YYYY): " Discharge
    read -p "Disease: " Disease
    read -p "Doctor: " Doctor

    # Append the new patient to the file
    echo "$Name,$ID,$Admission,$Discharge,$Disease,$Doctor" >> "$path"
    echo "New patient added successfully."
    
else
    echo "No patient was added."
fi
