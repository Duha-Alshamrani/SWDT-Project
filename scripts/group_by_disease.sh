#!/bin/bash

# Check if the script received at least one argument
# $# is the number of arguments passed to the script
# $1 is the first argument (expected to be the file path)
[ $# -lt 1 ] && { echo "Error: Missing argument"; exit 1; }

# Assign the first argument to a variable named path
path="$1"

# Print a message to indicate the script is starting
echo "Processing file: $path"

# Check if the file exists
if [ ! -f "$path" ]; then
    echo "Error: File '$path' not found!"
    exit 1
fi

# Process the CSV file and count patients by disease (assuming disease is in column 5)
awk -F',' 'NR > 1 {
    count[$5]++;
}
END {
    print "\nNumber of patients by disease:"
    for (d in count) {
        print d ": " count[d] " patients"
    }
}' "$path"

# Final message
echo "Data processing completed successfully."
