#!/bin/bash

#Student name and number

#validate the input arguments
validate_args() {

#Check if the correct number of arguments are provided
if [ $# -ne 2 ]; then
tput setaf 1
echo "Please provide two arguments: option and argument. Exiting..."
tput sgr0
exit 1
fi

#Store option and argument in variables
option=$1
argument=$2

case $option in
# Validate -z option
"-z")
if [[ $argument != "ASC" && $argument != "DSC" && $argument != "SHL" && $argument != "SLH" ]]; then
tput setaf 1
echo "Invalid argument for -z option. Exiting..."
tput sgr0
exit 1
fi
;;
# Validate -s option
"-s")
if [[ -z $argument ]]; then
tput setaf 1
echo "Invalid argument for -s option. Exiting..."
tput sgr0
exit 1
fi
;;
# Validate -b option
"-b")
operator=${argument%,*}
bytes=${argument#*,}
if [[ -z $operator || -z $bytes ]]; then
tput setaf 1
echo "Invalid argument for -b option. Exiting..."
tput sgr0
exit 1
fi
case $operator in
"GT") operator=">";;
"LT") operator="<";;
"LE") operator="<=";;
"GE") operator=">=";;
"EQ") operator="==";;
"NE") operator="!=";;
*)
tput setaf 1
echo "Invalid operator for -b option. Exiting..."
tput sgr0
exit 1
;;
esac
;;
*)
tput setaf 1
echo "Invalid option. Exiting..."
tput sgr0
exit 1
;;
esac
}

#Function to sort and display the output
display_output() {

#Get the list of files in /bin directory
files=$(ls /bin)

#Sort the files based on the option provided
case $1 in
"ASC") files=$(echo "$files" | sort -f);;
"DSC") files=$(echo "$files" | sort -rf);;
"SHL") files=$(ls -S /bin);;
"SLH") files=$(ls -s /bin);;
esac

#Display the files in columnar format
echo "Binary Name Binary Size"
echo "------------------- -----------"
for file in $files; do
size=$(stat -c%s "/bin/$file")
printf "%-20s %10d\n" $file $size
done
}

#filter the files based on the size
filter_by_size() {
    operator=$1
    bytes=$2
    files=$(find /bin -type f -printf "%s %p\n" | awk '{if( $1 '"$operator $bytes"') print $2}')
    if [ -z "$files" ]; then
    tput setaf 1
    echo "No matches found"
    tput sgr0
    exit 0
    fi
    for file in $files; do
    size=$(stat -c%s "$file")
    printf "%-20s %10d\n" $(basename $file) $size
    done
}

#Main script
if [ $# -eq 0 ]; then

#If no argument is provided, display the full listing of /bin directory
ls /bin
else
validate_args $1 $2

option=$1
argument=$2

case $option in
"-z")
  display_output $argument
  ;;
"-s")
  files=$(ls /bin | grep -i $argument)
  if [ -z "$files" ]; then
  tput setaf 1
    echo "No matches found"
    tput sgr0
    exit 0
  fi
  for file in $files; do
    size=$(stat -c%s "/bin/$file")
    printf "%-20s %10d\n" "$file" "$size"
  done
  ;;
"-b")
  filter_by_size $operator $bytes
  ;;
*)
tput setaf 1
  echo "Invalid option. Exiting..."
  tput sgr0
  exit 1
  ;;
esac
fi




