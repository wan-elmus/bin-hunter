#!/bin/bash

# Validate and store command line arguments
while getopts ":z:s:b:" opt; do
    case $opt in
    z) order_type="$OPTARG" ;;
    s) search_string="$OPTARG" ;;
    b) operator_bytes="$OPTARG" ;;
    \?) echo "Invalid option -$OPTARG. Exiting..." && exit 1 ;;
    :) echo "Option -$OPTARG requires an argument. Exiting..." && exit 1 ;;
    esac
done

# Check if multiple options were passed
if [[ ! -z $order_type && ! -z $search_string ]] || [[ ! -z $order_type && ! -z $operator_bytes ]] || [[ ! -z $search_string && ! -z $operator_bytes ]]; then
    echo "Please provide only one option at a time. Exiting..." && exit 1
fi

# Validate order type argument
if [[ ! -z $order_type ]]; then
    if [[ $order_type != "ASC" && $order_type != "DSC" && $order_type != "SHL" && $order_type != "SLH" ]]; then
    echo "Invalid order type $order_type passed. Exiting..." && exit 1
    fi
fi

# Validate search string argument
if [[ ! -z $search_string ]]; then
    if [[ ! $search_string =~ ^[A-Za-z0-9]+$ ]]; then
    echo "Invalid search string $search_string passed. Exiting..." && exit 1
    fi
fi

# Validate operator and bytes argument
if [[ ! -z $operator_bytes ]]; then
    if [[ ! $operator_bytes =~ ^[A-Za-z]{2},[0-9]+$ ]]; then
    echo "Invalid operator and bytes $operator_bytes passed. Exiting..." && exit 1
    fi
fi

# Get a listing of the /bin directory
listing=$(ls -l /bin)

# Check if listing was successful
if [[ $? -ne 0 ]]; then
    echo "Failed to get listing of /bin directory. Exiting..." && exit 1
fi

# Filter listing based on search string
if [[ ! -z $search_string ]]; then
    listing=$(echo "$listing" | grep -i "$search_string")
fi

# Check if any matches were found
if [[ -z $listing ]]; then
    echo "No matches found. Exiting..." && exit 0
fi

# Filter listing based on operator and bytes
if [[ ! -z $operator_bytes ]]; then
    operator=$(echo "$operator_bytes" | cut -d, -f1)
    bytes=$(echo "$operator_bytes" | cut -d, -f2)
    case $operator in
    GT) listing=$(echo "$listing" | awk '$5 > '$bytes'') ;;
    LT) listing=$(echo "$listing" | awk '$5 < '$bytes'') ;;
    LE) listing=$(echo "$listing" | awk '$5 <= '$bytes'') ;;
    GE) listing=$(echo "$listing" | awk '$5 >= '$bytes'') ;;
    EQ) listing=$(echo "$listing" | awk '$5 == '$bytes'') ;;
    NE) listing=$(echo "$listing" | awk '$5 != '$bytes'') ;;
esac
fi

Sort listing based on order type
if [[ ! -z $order_type ]]; then
case $order_type in
ASC) listing=$(echo "$listing" | sort -k5,5n) ;;
DSC) listing=$(echo "$listing" | sort -k5,5nr) ;;
SHL) listing=$(echo "$listing" | sort -k9) ;;
SLH) listing=$(echo "$listing" | sort -k9r) ;;
esac
fi

Print final listing
echo "$listing"

Exit successfully
exit 0



