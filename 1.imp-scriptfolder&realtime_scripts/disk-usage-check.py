import psutil
import logging

# Define the threshold for disk usage (percentage)
THRESHOLD = 80

# Define the log file path (modify as needed)
LOG_FILE = "/var/log/disk_usage.log"

# Configure logging
logging.basicConfig(filename=LOG_FILE, level=logging.INFO, format="[%(asctime)s] - %(levelname)s: %(message)s")

def check_disk_usage():
  """
  Checks disk usage for the root partition and logs the information.
  """
  try:
    # Get disk usage information for the root partition
    disk_usage = psutil.disk_usage('/').used / psutil.disk_usage('/').total * 100

    # Check if disk usage is above the threshold
    if disk_usage >= THRESHOLD:
      message = f"Disk usage on / is critically high at {disk_usage}%. Taking action (e.g., email notification, automated cleanup)."
      logging.critical(message)
      # Add your desired actions here, like sending an email notification
    else:
      message = f"Disk usage on / is at {disk_usage}%. Below critical threshold."
      logging.info(message)
  except (psutil.NoSuchPartitionError, PermissionError) as e:
    logging.error(f"Error checking disk usage: {e}")

if __name__ == "__main__":
  check_disk_usage()
  print("Disk usage check completed. Log updated.")

# Explanation:

# Imports: Import psutil for disk usage information and logging for log management.
# Threshold and Log File Path: Define THRESHOLD and LOG_FILE variables as before.
# Logging Configuration: Configure logging to write to the specified file with INFO level and a timestamp format.
# check_disk_usage Function:
# This function encapsulates the logic for checking disk usage.
# It uses psutil.disk_usage to get usage information for the root partition (/).
# The percentage is calculated and stored in disk_usage.
# An if statement checks if disk_usage is above or equal to THRESHOLD.
# If critical: A message with current usage and a call to action is logged using logging.critical.
# If below threshold: An informational message with current usage is logged using logging.info.
# The function includes exception handling for cases where the partition might not exist or permission errors occur.
# Main Execution:
# The script checks if it's the main program (__name__ == "__main__").
# If yes, it calls the check_disk_usage function.
# A confirmation message is printed to the console.
# How to Use:

# Save the script as a file (e.g., disk_monitor.py).
# Run the script: python disk_monitor.py.
# You can schedule it to run periodically using cron or a process manager like systemd.