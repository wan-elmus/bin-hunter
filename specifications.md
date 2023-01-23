Compulsory Requirements

1. Call the script searchbin.sh. Note: There will be a one (1) mark deduction from your achieved score if
   you script is submitted with a different name.
2. The script is to support and implement all of the options (flags) and argument(s) in the table below
   when provided at the command line at run time.
OPTION ARGUMENT
-z [order type]
EXAMPLE:
./searchbin.sh -z ASC
ASC – Order output by binary name alphabetically A-Z
DSC – Order output by binary name alphabetically Z-A
SHL – Order output by binary size highest to lowest
SLH – Order output by binary size lowest to highest
Please note: argument input is to be case-insensitive

-s [string]
EXAMPLE:
./searchbin.sh -s vmware
Return binaries that contain the specified string
Please note: argument input is to be case-insensitive

-b [operator],[bytes]
EXAMPLE:
./searchbin.sh -b GT,500000
Note: comma is compulsory; no spaces
between arguments permitted
Return binaries that match operator and bytes value provided
GT – greater than,[value in bytes]
LT – less than,[value in bytes]
LE – less than or equal to,[value in bytes]
GE – greater than or equal to,[value in bytes]
EQ – equal to,[value in bytes]
NE – not equal to,[value in bytes]
Please note: argument input is to be case-insensitive
Table 1: Script functionality requirements

3. If no flag/argument provided, a full listing of the /bin directory is output to screen

4. The script is to allow for only one (1) option/argument(s) to be run at a time, so if multiple options/arguments are passed by the user, the script is to terminate with message to user to try again with just a single option/argument(s)

5. All options and arguments passed at the command line are to be fully validated, and in the event an invalid option and/or argument(s) are passed, this must be detected, and the script terminated with an appropriate error message,    e.g. “Invalid [specifics] passed. Exiting...” and exit code

6. All output of results to terminal must be in the columnar, formatted fashion precisely as shown in the Search/Sort Binaries demonstration video

7. In the event that no matches are found for any particular search (options -s and -b), then the user is to be informed of this with an appropriate message, e.g. “No matches found”, and the script terminated.

8. Your script will be run in a working directory of the assessor's choosing, which will not be the /bin directory. Do not, therefore, hard-code your script to run in/from any particular directory.

9. Apart from getting a listing (ls) of the /bin directory’s contents for the purposes of the script’s functions, your script is not to do anything else in or to the /bin directory

10. Any files and/or folders created by your script in the course of its execution are to be removed upon the script’s termination. Please note: There will be a one (1) mark deduction from your achieved Page 4 of 6 score if any files and/or folders created by your script are left behind on the assessor’s machine at the conclusion of the marking process.

11. Your full name and student number must be placed at the top of your script (as comments) immediately after the shebang line. Please note: There will be a one (1) mark deduction from your achieved score if either or both of these items are absent.

12. To construct your script, use any combination of commands, utilities and programmatic techniques addressed in Modules 1-8 (inclusive). Be aware - use of commands, utilities and programmatic techniques not addressed in the unit’s content materials may be considered a red flag for academic misconduct.

13. Your script must contain accurate and informative ‘in-situ’ comments that explain all of the code elements it contains. Be aware – comments that are not germane to the code they describe, or a complete lack of comments, may both be considered red flags for academic misconduct.

14. The efficiency with which the commands, utilities and programmatic techniques have been utilised within your script will form part of your mark, with the total lines-of-code it contains not to exceed 230, including comments. If you exceed this limit, marks will be deducted based on the magnitude of this excess.
