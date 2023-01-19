# Search and sort commands and utilities located in /bin directory

Script starts by defining the validate_input() function, which checks if the number of arguments passed is greater than 2 and exits if true. It then checks the option flag passed and validates the value passed accordingly.

If the option flag is -z, it checks if the value passed is one of the four valid order types (ASC, DSC, SHL, SLH).
If the option flag is -s, it checks if the value passed is a non-empty string.
If the option flag is -b, it checks if the value passed is in the format of operator,bytes where operator is one of the six valid comparison operators (GT, LT, LE, GE, EQ, NE) and bytes is a number.
The script then defines the search_sort_binaries() function, which performs different actions based on the option flag passed.

If the option flag is -z, it sorts the files in the /bin directory in the specified order.
If the option flag is -s, it searches for files in the /bin directory that contain the specified string and prints them out.
If the option flag is -b, it searches for files in the /bin directory that have a file size that matches the specified comparison and value.
The script then defines the main() function which calls the validate_input() and search_sort_binaries() functions with the arguments passed.

Finally, the script calls the main() function with the passed arguments. The script can be executed by running it in the terminal and passing the appropriate arguments and options.
