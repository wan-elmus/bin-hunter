#!/bin/bash

#Student name and number

#validate input arguments
validate_args() {
if [[ $1 == "-z" ]]; then
if [[ $2 == "ASC" || $2 == "DSC" || $2 == "SHL" || $2 == "SLH" ]]; then
return 0
else
tput setaf 1
echo "Invalid argument passed for option -z. Exiting..."
tput sgr0
exit 1
fi
elif [[ $1 == "-s" ]]; then
if [[ -n $2 ]]; then
return 0
else
tput setaf 1
echo "No argument passed for option -s. Exiting..."
tput sgr0
exit 1
fi
elif [[ $1 == "-b" ]]; then
if [[ $2 =~ ^(GT|LT|LE|GE|EQ|NE),[0-9]+$ ]]; then
return 0
else
tput setaf 1
echo "Invalid argument passed for option -b. Exiting..."
tput sgr0
exit 1
fi
else
tput setaf 1
echo "Invalid option passed. Exiting..."
tput sgr0
exit 1
fi
}

#Check if only one option/argument is provided
if [ $# -gt 2 ]; then
tput setaf 1
echo "Please provide only one option/argument at a time. Exiting..."
tput sgr0
exit 1
fi

#Validate input arguments
validate_args $1 $2

#Store option and argument in variables
option=$1
argument=$2

#Get all files in /bin directory and store in variable
binaries=$(ls /bin)

#Sort/search based on option provided
if [[ $option == "-z" ]]; then
if [[ $argument == "ASC" ]]; then
binaries=$(echo "$binaries" | sort)
elif [[ $argument == "DSC" ]]; then
binaries=$(echo "$binaries" | sort -r)
elif [[ $argument == "SHL" ]]; then
binaries=$(ls -S /bin)
elif [[ $argument == "SLH" ]]; then
binaries=$(ls -s /bin)
fi
elif [[ $option == "-s" ]]; then
binaries=$(echo "$binaries" | grep -i "$argument")
if [[ -z $binaries ]]; then
echo "No matches found"
exit 1
fi
elif [[ $option == "-b" ]]; then
operator=$(echo "$argument" | cut -f1 -d,)
bytes=$(echo "$argument" | cut -f2 -d,)
for binary in $binaries; do
binary_size=$(ls -s /bin/$binary | cut -f1 -d' ')
if [[ $operator == "GT" && $binary_size -gt $bytes ]]; then
sorted_binaries="$sorted_binaries $binary"
elif [[ $operator == "LT" && $binary_size -lt $bytes ]]; then
sorted_binaries="$sorted_binaries $binary"
elif [[ $operator == "LE" && $binary_size -le $bytes ]]; then
sorted_binaries="$sorted_binaries $binary"
elif [[ $operator == "GE" && $binary_size -ge $bytes ]]; then
sorted_binaries="$sorted_binaries $binary"
elif [[ $operator == "EQ" && $binary_size -eq $bytes ]]; then
sorted_binaries="$sorted_binaries $binary"
elif [[ $operator == "NE" && $binary_size -ne $bytes ]]; then
sorted_binaries="$sorted_binaries $binary"
fi
done
binaries=$sorted_binaries
if [[ -z $binaries ]]; then
tput setaf 1
echo "No matches found"
tput sgr0
exit 1
fi
fi

#Print results in columnar format
printf "%-20s %-10d\n" "Binary" "Size (bytes)"
for binary in $binaries; do
binary_size=$(ls -s /bin/$binary | cut -f1 -d' ')
printf "%-20s %-10d\n" "$binary" "$binary_size"
done

#Exit script
exit 0