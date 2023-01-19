#!/bin/bash

#Student's name and number

#Function to validate the input arguments
validate_args() {
    #Check if only one argument is provided
    if [ $# -ne 1 ]; then
        echo "Please provide only one option/argument at a time. Exiting..."
        exit 1
    fi

    #Split the option and argument
    option=${1:0:2}
    argument=${1:3}

    case $option in
        # Validate -z option
        "-z")
            if [[ $argument != "ASC" && $argument != "DSC" && $argument != "SHL" && $argument != "SLH" ]]; then
                echo "Invalid argument for -z option. Exiting..."
                exit 1
            fi
            ;;
        # Validate -s option
        "-s")
            if [[ -z $argument ]]; then
                echo "Invalid argument for -s option. Exiting..."
                exit 1
            fi
            ;;
        # Validate -b option
        "-b")
            operator=${argument%,}
            bytes=${argument#,}
            if [[ -z $operator || -z $bytes ]]; then
                echo "Invalid argument for -b option. Exiting..."
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
                    echo "Invalid operator for -b option. Exiting..."
                    exit 1
                    ;;
            esac
            ;;
        *)
            echo "Invalid option. Exiting..."
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

#Main script
if [ $# -eq 0 ]; then
    #If no argument is provided, display the full listing of /bin directory
    ls /bin
else
    validate_args $1

    option=${1:0:2}
    argument=${1:3}

    case $option in
    "-z")
            display_output $argument
            ;;
        "-s")
            # Search for files containing the specified string
            files=$(ls /bin | grep -i $argument)
            if [ -z "$files" ]; then
                echo "No matches found"
                exit 0
            fi
            for file in $files; do
                size=$(stat -c%s "/bin/$file")
                printf "%-20s %10d\n" $file $size
            done
            ;;
        "-b")
            ;;
    esac
fi
