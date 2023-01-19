#!/bin/bash

# Student name and student number

# validate input arguments and options
validate_input() {
    # revoke multiple options
    if [ $# -gt 2 ]; then
    echo "Please provide only one option at a time. Exiting..."
    exit 1
    fi

    # Check if option is -z
    if [ "$1" == "-z" ]; then
    # Check if order type is valid
    if [ "$2" != "ASC" ] && [ "$2" != "DSC" ] && [ "$2" != "SHL" ] && [ "$2" != "SLH" ]; then
        echo "Invalid order type passed. Exiting..."
        exit 1
    fi
    # Check if option is -s
    elif [ "$1" == "-s" ]; then
    # Check if string is not empty
    if [ -z "$2" ]; then
        echo "Please provide a string to search. Exiting..."
        exit 1
    fi
    # Check if option is -b
    elif [ "$1" == "-b" ]; then
    # Split operator and bytes using comma as delimiter
    IFS=',' read -ra args <<< "$2"
    operator=${args[0]}
    bytes=${args[1]}
    # Check if operator is valid
    if [ "$operator" != "GT" ] && [ "$operator" != "LT" ] && [ "$operator" != "LE" ] && [ "$operator" != "GE" ] && [ "$operator" != "EQ" ] && [ "$operator" != "NE" ]; then
        echo "Invalid operator passed. Exiting..."
        exit 1
    fi
    # Check if bytes is a number
    if ! [[ "$bytes" =~ ^[0-9]+$ ]]; then
        echo "Invalid bytes value passed. Exiting..."
        exit 1
    fi
    # If invalid option provided
    else
    echo "Invalid option passed. Exiting..."
    exit 1
    fi
}

# search and sort binaries in /bin directory
search_sort_binaries() {
    # Store binaries in /bin directory in an array
    bin_files=($(ls /bin))
    # Check if option is -z
    if [ "$1" == "-z" ]; then
    order_type="$2"
    # Sort array alphabetically in ascending or descending order
    if [ "$order_type" == "ASC" ]; then
        sort -f bin_files
    elif [ "$order_type" == "DSC" ]; then
        sort -r -f bin_files
    elif [ "$order_type" == "SHL" ]; then
        sort -h bin_files
    elif [ "$order_type" == "SLH" ]; then
        sort -hr -f bin_files
    fi
    # Check if option is -s
elif [ "$1" == "-s" ]; then
search_string="$2"
# Search for binaries that contain the specified string
for file in "${bin_files[@]}"; do
if [[ "$file" =~ "$search_string" ]]; then
echo "$file"
fi
done
# Check if option is -b
elif [ "$1" == "-b" ]; then
operator="$2"
bytes="$3"
for file in "${bin_files[@]}"; do
# Get file size in bytes
file_size=$(wc -c <"/bin/$file")
# Compare file size with specified bytes using the operator
if [ "$operator" == "GT" ] && [ "$file_size" -gt "$bytes" ]; then
echo "$file"
elif [ "$operator" == "LT" ] && [ "$file_size" -lt "$bytes" ]; then
echo "$file"
elif [ "$operator" == "LE" ] && [ "$file_size" -le "$bytes" ]; then
echo "$file"
elif [ "$operator" == "GE" ] && [ "$file_size" -ge "$bytes" ]; then
echo "$file"
elif [ "$operator" == "EQ" ] && [ "$file_size" -eq "$bytes" ]; then
echo "$file"
elif [ "$operator" == "NE" ] && [ "$file_size" -ne "$bytes" ]; then
echo "$file"
fi
done
fi
}

#main function
main() {
validate_input "$@"
search_sort_binaries "$@"
}

#call main function
main "$@"
