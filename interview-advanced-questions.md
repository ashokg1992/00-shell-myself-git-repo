
How do you handle error checking in shell script to ensure a command was executed successfully?
How do you handle and trap signals in a shell script?
How do you debug a shell script?
How do you handle command line arguments in a shell script?
How do you read a file line by line in a shell script?
How do you handle file locking in a shell script?
How do you compress a file in shell script?
How do you manage background processes in a shell script?
How do you create a temporary file in a shell script?
How do you pass JSON data in a shell script?

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

################## Question 1 ################## 
#!/bin/bash
#using if statement
ls /nonexistent
if [$? -eq 0 ]; then
  echo "Command executed successfully"
else
  echo "Command failed execution"
done

#using set -e
set -e
ls /nonexistent
echo "This line will not be executed if the above command fails"

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

################## Question 2 ################## 
#!/bin/bash
# Trap SIGINT (Ctrl+C) and SIGTERM
trap 'echo "Signal received, cleaning up..."; cleanup_function; exit' SIGINT SIGTERM

# Define the cleanup function
cleanup_function() {
  echo "Performing cleanup tasks"
  # Add cleanup commands here
}

echo "Running script. Press Ctrl+C to test signal trapping."
while true; do
  sleep 1
done
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

################## Question 3 ################## 
# Enable debugging for part of the script
set -x
ls /home/ubuntu
sudo service jenkins status
set +x

# Or run the entire script in debug mode
bash -x scriptname.sh

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

################## Question 4 ################## 
#!/bin/bash
# Define an array
my_array=(element1 element2 element3)

# Access an element
echo ${my_array[0]} # outputs: element1

# Access all elements
echo ${my_array[@]} # outputs: element1 element2 element3

# Iterate over elements
for element in "${my_array[@]}"; do
  echo $element
done

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

################## Question 5 ################## 
#!/bin/bash
# Using expr
result=$(expr 3 + 4)
echo $result # outputs: 7

# Using $(( ... ))
result=$((3 + 4))
echo $result # outputs: 7

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

################## Question 6 ################## 
#!/bin/bash
cmd="ls -l"
eval $cmd # executes 'ls -l'
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

################## Question 7 ################## 
#!/bin/bash
echo "First argument: $1"
echo "All arguments: $@"
echo "Number of arguments: $#"

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

################## Question 8 ################## 
#!/bin/bash
VAR="dgruploads"
if [ -z "$VAR" ]; then
  echo "VAR is not set"
else
  echo "VAR is set to $VAR"
fi
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

################## Question 9 ################## 
#!/bin/bash
while IFS= read -r line; do
  echo "$line"
done < script.sh
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

################## Question 10 ################## 
#!/bin/bash
exec 200>/var/lock/mylockfile
flock -n 200 || exit 1

# Critical section
echo "Locked section"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

################## Question 11 ################## 
#!/bin/bash
# Compress a directory
tar -czf archive.tar.gz /path/to/directory

# Decompress an archive
tar -xzf archive.tar.gz

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

################## Question 12 ################## 
#!/bin/bash
ls -l &
pid1=$!
sudo service jenkins status &
pid2=$!

wait $pid1
wait $pid2

echo "Both background processes have finishe
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

################## Question 13 ################## 
#!/bin/bash
tempfile=$(mktemp)
echo "Temporary file created at: $tempfile"

# Use the temporary file
echo "Some data" > $tempfile

# Clean up
rm -f $tempfile
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

################## Question 14 ################## 
#!/bin/bash
json='{"name": "dgruplaods", "age": 5}'
name=$(echo $json | jq -r '.name')
age=$(echo $json | jq -r '.age')

echo "Name: $name"
echo "Age: $age"
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

################## Question 15 ################## 
str="Hello, World!"

# Extract a substring
echo ${str:7} # outputs: World!
echo ${str:7:5} # outputs: World

# Replace a substring
echo ${str/World/dgruploads} # outputs: Hello, Everyone!

# Get string length
echo ${#str} # outputs: 13

################################################