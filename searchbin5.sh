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
    option=$(echo $1 | tr '[:upper:]' '[:lower:]')
    argument=$(echo $2 | tr '[:upper:]' '[:lower:]')

    case $option in
    # Validate -z option
    "-z")
    if [[ $argument != "asc" && $argument != "asc" && $argument != "shl" && $argument != "slh" ]]; then
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
    "gt") operator=">";;
    "lt") operator="<";;
    "le") operator="<=";;
    "ge") operator=">=";;
    "eq") operator="==";;
    "ne") operator="!=";;
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
# Function to print the header
print_header() {
    printf "%-20s %23s\n" "NAME" "SIZE"
} 

#Function to sort and display the output
display_output() {

    #Get the list of files in /bin directory
    files=$(ls /bin)

    #Sort the files based on the option provided
    case $1 in
    "asc") files=$(echo "$files" | sort -f);;
    "dsc") files=$(echo "$files" | sort -rf);;
    "shl") files=$(ls -S /bin);;
    "slh") files=$(ls -s /bin);;
    esac
    print_header
    #Display the files in columnar format
    for file in $files; do
        size=$(stat -c%s "/bin/$file")
        if [[ $size -lt 1000 ]]; then
                printf "%-20s %20db\n" $file $size
        elif [[ $size -ge 1000000 ]]; then
                size=$(echo "scale=2; $size/1000000" | bc)
                printf "%-20s %20.2fMb\n" $file $size
        else
                size=$(echo "scale=2; $size/1000" | bc)
                printf "%-20s %20.2fkb\n" $file  $size
        fi
    done
}

#filter the files based on the size
filter_by_size() {
    operator=$1
    bytes=$2

    # Convert bytes to the correct format for the -size option
    if [[ $bytes -lt 1000 ]]; then
        size_format="c"
    elif [[ $bytes -lt 1000000 ]]; then
        bytes=$(echo "scale=2; $bytes/1000" | bc)
        size_format="k"
    else
        bytes=$(echo "scale=2; $bytes/1000000" | bc)
        size_format="M"
    fi

    files=$(find /bin -type f -printf "%s %p\n" | awk '{if( $1 '"$operator $bytes"') print $2}')

    
  


    if [ -z "$files" ]; then
        tput setaf 1
        echo "No matches found"
        tput sgr0
        exit 0
    fi
        for file in $files; do
        size=$(stat -c%s "$file")
        printf "%-20s %20d\n" $(basename $file) $size
    done
}

#list the utilities and commands in /bin directory alphabetically
list_alphabetically() {
    files=$(ls /bin | sort -f)
    print_header
    for file in $files; do
        size=$(stat -c%s "/bin/$file")
        if [[ $size -lt 1000 ]]; then
                printf "%-20s %20dfb\n" $file $size
        elif [[ $size -ge 1000000 ]]; then
                size=$(echo "scale=2; $size/1000000" | bc)
                printf "%-20s %20.2fmb\n" $file $size
        else
                size=$(echo "scale=2; $size/1000" | bc)
                printf "%-20s %20.2fkb\n" $file  $size
        fi
    done
}


#Main script
#If no argument is provided, display the full listing of /bin directory
if [ $# -eq 0 ]; then
    list_alphabetically
else
    validate_args $1 $2

    option=$1
    argument=$2

    case $option in
    "-z")
        display_output $argument
        ;;
    "-s")
        files=$(ls /bin)
       files=$(ls /bin)
    if [ -z "$files" ]; then
        tput setaf 1
        echo "No matches found"
        tput sgr0
        exit 0
    fi
        print_header
        for file in $files; do
            size=$(stat -c%s "/bin/$file")
            if [[ $size -lt 1000 ]]; then
                printf "%-20s %20d b\n" $file $size
            elif [[ $size -ge 1000000 ]]; then
                size=$(echo "scale=2; $size/1000000" | bc)
                printf "%-20s %20.2fMb\n" $file $size
            else
                size=$(echo "scale=2; $size/1000" | bc)
                printf "%-20s %20.2fkb\n" $file  $size
            fi
        done
        ;;
    "-b")
        operator=${argument%,*}
        bytes=${argument#*,}
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
