# 2. Disk Usage Check Script
# Script
#!/bin/bash
THRESHOLD=80
# Check disk usage and print a warning if usage is above the threshold df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }' |
while read output;
do
usage=$(echo $output | awk '{ print $1}' | cut -d'%' -f1)
partition=$(echo $output | awk '{ print $2 }')
if [ $usage -ge $THRESHOLD ]; then
echo "Warning: Disk usage on $partition is at ${usage}%"
fi
done


# Explanation
# • THRESHOLD: Sets the disk usage percentage threshold.

# • df -H: Lists disk usage in human-readable format.

# • grep -vE '^Filesystem|tmpfs|cdrom' : Filters out unnecessary lines.

# • awk '{ print $5 " " $1 }' : Extracts the usage percentage and partition name.

# • while read output: Iterates over each line of the filtered output.

# • usage=$(echo $output | awk '{ print $1}' | cut -d'%' -f1): Extracts the usage percentage.

# • partition=$(echo $output | awk '{ print $2 }'): Extracts the partition name.

# • if [ $usage -ge $THRESHOLD ]; then: Checks if the usage exceeds the threshold.

# • echo "Warning: Disk usage on 𝑝𝑎𝑟𝑡𝑖𝑡𝑖𝑜𝑛𝑖𝑠𝑎𝑡{usage}%" : Prints a warning message.


===================================================

1. Scenario: Monitoring Disk Usage

Question: How would you write a shell script to monitor disk usage and send an email alert
if usage exceeds 90%?
Answer:
#!/bin/bash
THRESHOLD=90
EMAIL="admin@example.com"
df -h | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 "
" $1 }' | while read output; do
usage=$(echo $output | awk '{ print $1}' | sed 's/%//g')
partition=$(echo $output | awk '{ print $2 }')
if [ $usage -ge $THRESHOLD ]; then
echo "Running out of space \"$partition ($usage%)\"" |
mail -s "Disk Space Alert: $partition ($usage%)" $EMAIL
fi
done

# Explanation:
# • df -h: Get disk usage in human-readable format.
# • grep -vE '^Filesystem|tmpfs|cdrom': Exclude certain filesystems.
# • awk '{ print $5 " " $1 }': Print usage and partition.
# • Loop through each line and check if usage exceeds threshold, then send an email.


=====================================================================
#!/bin/bash

# Define the threshold for disk usage (percentage)
THRESHOLD=80

# Define the log file path (modify as needed)
LOG_FILE="/var/log/disk_usage.log"

# Capture the current date and time
timestamp=$(date +"%Y-%m-%d %H:%M:%S")

# Get disk usage information using df command
disk_usage=$(df -hP / | awk '{print $5}')  # Get usage percentage for the root partition

# Remove trailing "%" from the usage percentage
disk_usage=${disk_usage%%\%}

# Check if disk usage is above the threshold
if [[ $disk_usage -ge $THRESHOLD ]]; then
  message="Disk usage on / is critically high at ${disk_usage}%. Taking action (e.g., email notification, automated cleanup)."
  echo "[${timestamp}] - CRITICAL: ${message}" >> "${LOG_FILE}" 2>&1
  # Add your desired actions here, like sending an email notification
else
  message="Disk usage on / is at ${disk_usage}%. Below critical threshold."
  echo "[${timestamp}] - INFO: ${message}" >> "${LOG_FILE}" 2>&1
fi

# echo "Disk usage check completed. Log updated."

# Threshold: Define the THRESHOLD variable for critical disk usage (modify this value based on your needs).
# Log File Path: Set the path to the log file using LOG_FILE.
# Timestamp: Capture the current date and time.
# Disk Usage: Use df -hP / to get disk usage information for the root partition (/). The awk '{print $5}' part extracts the usage percentage from the output.
# Remove Trailing "%": The disk_usage=${disk_usage%%\%} removes the trailing "%" symbol from the percentage value for comparison.
# Threshold Check: The if statement checks if disk_usage is greater than or equal to THRESHOLD.
# If critical: A message with the current usage and a call to action is logged to the file with a "CRITICAL" tag. You can add further actions here (e.g., sending an email notification).
# If below threshold: An informational message is logged with the current usage.
# Logging: Both critical and informational messages are appended to the log file with timestamps.
# Confirmation: A confirmation message is printed to the console.

================================================