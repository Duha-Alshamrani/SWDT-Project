#!/bin/bash

# Check if the script received at least one argument
# $# is the number of arguments passed to the script
# $1 is the first argument (expected to be the file path)
[ $# -lt 1 ] && { echo "Error: Missing file argument"; exit 1; }
# Assign the first argument to a variable named 'path'
path="$1"

# Check if the file exists
if [ ! -f "$path" ]; then
    echo "File '$path' not found!"  # Print error message if file is missing
    exit 1  # Exit the script with a non-zero status
fi
# Inform the user that the visit calculation is starting
echo "Calculating number of visits per patient..."

# Use awk to process the CSV file and count visits per patient
# -F',' : sets comma as the field separator
# NR > 1 : skips the header line
# visits[$1]++ : increments the count for each patient ID found in column 1
# After processing all lines, print each patient ID with their corresponding visit count
awk -F',' 'NR > 1 {
    visits[$1]++;
}
END {
    print "\nNumber of visits per patient:"  # Print header before results
    for (id in visits) {
        print id ": " visits[id] " visits"  # Print patient ID and number of visits
    }
}' "$path"
# Indicate completion of the process
echo "Done."
