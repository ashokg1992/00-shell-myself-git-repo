
---------------------------------------------
Script File Name Adaptability:

Scenario 1 discusses how to write a shell script that adapts to changes in its file name, ensuring the output reflects the new name without hardcoding the file name inside the script. This is achieved using $0 to dynamically capture the script's name.
   file1.sh
     echo "this is $0"
    
    now we run this file 
    sh file1.sh   # o/p: this is file one
    now in same file run as 
    mv file1.sh file2.sh
    sh file2.sh     # o/p ia thia is file2.sh

 
 --------------------------------------------------------------
Using Configuration Files:
Scenario 2 highlights the importance of avoiding hardcoding values by loading configuration properties from an external config file using the source command. This approach makes it easier to manage and update properties used across multiple scripts.
Handling Script Options with Case and Shift:

i have applicatiatin properties file and i use it in my shell script, then how you do?
    - we maintain two files - application , shell files,. in shell file we give source as application file and  call them it this file
----------------------------------------------------------------------------

Scenario 3 focuses on handling multiple script options (-B, -T, etc.) using a combination of the case statement and the shift command. This method simplifies the script logic and makes it more maintainable, especially when adding new options.

Present Working Directory (PWD) Tip:
A tip is shared for obtaining the current working directory in a more flexible way using awk and cut to manipulate the pwd output, ensuring consistent results across different directory structures.

Creating Command Shortcuts:
Instructions are provided on creating shortcuts for frequently used commands by adding alias definitions to the .bashrc or equivalent startup script and reloading the shell to apply the changes. This improves efficiency and convenience for repetitive tasks.





