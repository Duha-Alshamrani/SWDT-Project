#!/bin/bash
# Step 1: Input dataset
#check if the file name passed
if [ $# -lt 1 ]; then
    echo "Enter the file name as argument"
    exit 1
fi
dataset=$1

echo "============================"
echo " Patient Data Processor"
echo "============================"

if [[ ! -f "$dataset" ]]; then
  echo "Error: File not found. Exiting."
  exit 1
fi

# Step 2: Validate Columns
echo "[Step 2] Validating columns..."
./check_columns.sh "$dataset"
if [[ $? -ne 0 ]]; then

  echo "Validation failed. Exiting."
  exit 1
fi

# Step 3: Clean Data
echo "[Step 3] Cleaning data..."
./cleaning_data.sh "$dataset"

# Step 4: Add New Patients?
  ./add_patient.sh "cleand_patients.csv"


# Step 5: Menu for data processing
while true; do
  echo ""
  echo "======== Data Processing Menu ========"
  echo "1) Calculate Stay Duration"
  echo "2) Group by Disease"
  echo "3) Analyze Visits"
  echo "0) Exit"
  echo "======================================"
  read -p "Choose an option [0-3]: " option

  case $option in
    1)
      ./stay_duration.sh "cleand_patients.csv"
      echo "The stay durations has been calculated in file, you can see it in your files" 
      ;;
    2)
      ./group_by_disease.sh "cleand_patients.csv"
      ;;
    3)
      ./analyze_visits.sh "cleand_patients.csv"
      ;;
    0)
      echo "Done."
      break
      ;;
    *)
      echo "Invalid choice. Try again."
      ;;
  esac
done
# Step 6: Generate Top Doctors Report 
./report.sh "cleand_patients.csv"
