#!/bin/bash

# Check if file argument is passed
if [ $# -lt 1 ]; then
  echo "❌ Error: Please provide the data file name as an argument."
  exit 1
fi

data=$1

# Welcome message at the start
clear
echo "==================================================="
echo "🏥 Welcome to the Hospital Data Management System"
echo "==================================================="
echo ""

# ✅ Step 1: Validate required columns
echo "🔎 Checking required columns in the file..."
./check_columns.sh "$data"

echo "✅ Done Checking the required columns"

# 🧼 Step 2: Clean the data
echo "🧽 Cleaning patient data..."
./cleaning_data.sh "$data"
echo "✅ Data cleaned and saved to cleand_patients.csv"


# ➕ Step 3: Add New Patients?
echo "➕ Add new patient..."
  ./add_patient.sh "cleand_patients.csv"


# ▶️ Start interactive menu
 while true; do
  echo ""
  echo "=================================="
  echo "🏥 Interactive Menu "
  echo "=================================="
  echo "1) 🧬 Group patients by disease"
  echo "2) 🔄 Analyze patient visits"
  echo "3) 📅 Calculate stay duration"
  echo "4) 👨‍⚕️ View top 5 doctors"
  echo "0) ❌ Exit"
  echo "=================================="

  read -p "Choose an option [0-4]: " option

  case $option in
    1)
     	./group_by_disease.sh "cleand_patients.csv" ;;
    2) 
    	./analyze_visits.sh "cleand_patients.csv" ;; 
    3) 
    	./stay_duration.sh "cleand_patients.csv" 
    	echo "The stay durations has been calculated in file, you can see it in your files ✔" ;;
    4) 
    	./report.sh "cleand_patients.csv" ;;
    0)
     	echo "✔ Done! Thank you for using the Hospital Data Management System"
        break ;;
    *) 
    	echo "❌ Invalid choice. Try again." ;;
  esac

done
