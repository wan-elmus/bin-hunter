![alt text](img/binhunt.PNG)


# Search and sort commands and utilities located in /bin directory
<Student_name_and_number_are_included_because_it_was_one_of_the_requirements_for_the_script_have_tried_as_much_as_possible_to__mplement_everything_the_requirements_demand>

This bash script takes in two input arguments. The first argument is an option and the second argument is an argument. The script first validates the input arguments to ensure that the correct number of arguments are provided, and that the option and argument are valid. If the arguments are invalid, the script exits. If the arguments are valid, the script performs different actions depending on the option provided. 
The options are:

"-z": sorts and displays the binary files in the /bin directory based on the argument provided (ASC, DSC, SHL, or SLH) and shows the name and size of the files in a columnar format.

"-s": searches for and displays the binary files in the /bin directory that match the argument provided (case-insensitive) and shows the name and size of the files in a columnar format.

"-b": filters and displays the binary files in the /bin directory based on the size argument provided (in bytes) and shows the name and size of the files in a columnar format.

If no arguments are provided, it simply lists the files in the /bin directory.

If invalid arguments are provided, it displays an error message and exits.

## How to run the Script with different arguments

*Sorting in ascending order: "./scriptname.sh -z ASC" or "bash scriptname.sh -z ASC"*

*Sorting in descending order: "./scriptname.sh -z DSC" or "bash scriptname.sh -z DSC"*

*Sorting by size in descending order: "./scriptname.sh -z SHL" or "bash scriptname.sh -z SHL"*

*Sorting by size in ascending order: "./scriptname.sh -z SLH" or "bash scriptname.sh -z SLH"*

*Searching for files containing a specific string: "./scriptname.sh -s <string>" or "bash scriptname.sh -s <string>"*

*Sorting by file size based on a specific operator and bytes: "./scriptname.sh -b <operator,bytes>" or "bash scriptname.sh -b <operator,bytes>"*

*Displaying the full listing of /bin directory: "./scriptname.sh" or "bash scriptname.sh"*
