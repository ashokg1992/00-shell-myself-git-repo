
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

I want to automate the deployment of an application to multiple servers. How would you achieve this using a shell script?
#!/bin/bash

# Define an array of server IP addresses or hostnames
SERVERS=("server1.example.com" "server2.example.com")
# Path to your application files
APP_PATH="/home/ubuntu/index.html"
# Destination path on the remote servers
DEPLOY_PATH="/var/www/html/"

# Loop through each server and deploy the application
for SERVER in "${SERVERS[@]}"; do
    echo "Deploying to $SERVER"
    # Securely copy application files to the server
    scp -r $APP_PATH user@$SERVER:$DEPLOY_PATH
    # Restart the application service on the server
    ssh user@$SERVER "systemctl restart apache2"
    echo "Deployment to $SERVER completed"
done

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

 Create a script to monitor disk usage and send an alert if usage exceeds 80%.
#!/bin/bash

# Define the disk usage threshold
THRESHOLD=80

# Get disk usage information, excluding certain filesystems
df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }' | while read output; do
    usage=$(echo $output | awk '{ print $1}' | sed 's/%//g')
    partition=$(echo $output | awk '{ print $2 }')
    if [ $usage -ge $THRESHOLD ]; then
        echo "Alert: High disk usage on $partition ($usage%)"
        # Send email or other alert here (e.g., using mail command)
    fi
done

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Write a script to check if a service is running, and start it if it’s not.

#!/bin/bash

# Define the service to check
SERVICE="httpd"

# Check if the service is active
if ! systemctl is-active --quiet $SERVICE; then
    echo "$SERVICE is not running, starting it..."
    systemctl start $SERVICE
    echo "$SERVICE started"
else
    echo "$SERVICE is already running"
fi

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

 Write a script to backup logs older than 7 days and delete the original files.
 #!/bin/bash

# Define the log directory and backup directory
LOG_DIR="/var/log/myapp"
BACKUP_DIR="/backup/logs"

# Find and archive logs older than 7 days
find $LOG_DIR -type f -mtime +7 -exec tar -rvf $BACKUP_DIR/logs_backup_$(date +%F).tar {} \; -exec rm {} \;
echo "Logs older than 7 days have been backed up and deleted."


 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Create a script to automate database backup.

#!/bin/bash

# Define database credentials and backup directory
DB_NAME="mydatabase"
DB_USER="dbuser"
DB_PASS="dbpass"
BACKUP_DIR="/backup/db"

# Perform the backup using mysqldump
mysqldump -u $DB_USER -p$DB_PASS $DB_NAME > $BACKUP_DIR/db_backup_$(date +%F).sql
echo "Database backup completed."

################## Question 6 ##################
 Write a script to rotate logs on a weekly basis.

#!/bin/bash

# Define the log directory and archive directory
LOG_DIR="/var/log/myapp"
ARCHIVE_DIR="/archive/logs"

# Move logs older than 7 days to the archive directory
find $LOG_DIR -type f -name "*.log" -mtime +7 -exec mv {} $ARCHIVE_DIR \;
echo "Weekly log rotation completed."


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

 Write a script to check the status of multiple services and restart any that are not running.

#!/bin/bash

# Define the services to check
SERVICES=("nginx" "mysql" "redis")

# Loop through each service and check its status
for SERVICE in "${SERVICES[@]}"; do
    if ! systemctl is-active --quiet $SERVICE; then
        echo "$SERVICE is not running, restarting it..."
        systemctl restart $SERVICE
        echo "$SERVICE restarted"
    else
        echo "$SERVICE is running"
    fi
done

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

 Create a script to update a web application by pulling the latest code from a Git repository.

#!/bin/bash

# Define the web application directory and Git repository
WEB_DIR="/var/www/myapp"
GIT_REPO="https://github.com/user/myapp.git"

# Change to the application directory and pull the latest code
cd $WEB_DIR
git pull $GIT_REPO
echo "Web application updated from the latest code."
# Restart the web server
systemctl restart nginx

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

 Write a script to compress and archive old log files.

#!/bin/bash

# Define the log directory and archive directory
LOG_DIR="/var/log/myapp"
ARCHIVE_DIR="/archive/logs"

# Find and compress logs older than 30 days
find $LOG_DIR -type f -name "*.log" -mtime +30 -exec gzip {} \;
# Move compressed logs to the archive directory
find $LOG_DIR -type f -name "*.log.gz" -mtime +30 -exec mv {} $ARCHIVE_DIR \;
echo "Old log files have been compressed and archived."
 
 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Write a script automate the cleanup of temporary files older than 10 days.

#!/bin/bash

# Define the temporary directory
TEMP_DIR="/tmp"

# Find and delete files older than 10 days
find $TEMP_DIR -type f -mtime +10 -exec rm {} \;
echo "Temporary files older than 10 days have been deleted."


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


🔹 Question 11: Write a script to monitor CPU usage and alert if it exceeds a certain threshold.

#!/bin/bash

# Define the CPU usage threshold
THRESHOLD=80

# Get current CPU usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
if (( $(echo "$CPU_USAGE > $THRESHOLD" | bc -l) )); then
    echo "Alert: High CPU usage ($CPU_USAGE%)"
    # Send email or other alert here (e.g., using mail command)
fi


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Write a script to install a list of packages.

#!/bin/bash

# Define the list of packages to install
PACKAGES=("nginx" "mysql-server" "redis")

# Loop through each package and install it if not already installed
for PACKAGE in "${PACKAGES[@]}"; do
    if ! dpkg -l | grep -q $PACKAGE; then
        echo "Installing $PACKAGE..."
        sudo apt-get install -y $PACKAGE
        echo "$PACKAGE installed"
    else
        echo "$PACKAGE is already installed"
    fi
done


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Write a script to sync a local directory with a remote directory using rsync.

#!/bin/bash

# Define the local and remote directories
LOCAL_DIR="/path/to/local"
REMOTE_USER="user"
REMOTE_HOST="remote_host"
REMOTE_DIR="/path/to/remote"

# Sync the local directory with the remote directory
rsync -avz $LOCAL_DIR $REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR
echo "Local directory synced with remote directory."



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

 Write a script to check the health of a web application by sending an HTTP request and checking the response.
#!/bin/bash

# Define the URL and expected HTTP status code
URL="http://example.com"
EXPECTED_STATUS=200

# Send an HTTP request and get the status code
STATUS=$(curl -s -o /dev/null -w "%{http_code}" $URL)
if [ $STATUS -ne $EXPECTED_STATUS ]; then
    echo "Alert: Web application is not healthy. Status code: $STATUS"
    # Send email or other alert here (e.g., using mail command)
else
    echo "Web application is healthy. Status code: $STATUS"
fi


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Write a script to automate the configuration of a new server with necessary packages and settings.

#!/bin/bash

# Define the list of packages to install
PACKAGES=("nginx" "mysql-server" "redis")
# Define firewall rules to allow
FIREWALL_RULES=("80/tcp" "443/tcp")

# Update package list and install packages
sudo apt-get update
for PACKAGE in "${PACKAGES[@]}"; do
    sudo apt-get install -y $PACKAGE
done

# Configure the firewall to allow specified rules
for RULE in "${FIREWALL_RULES[@]}"; do
    sudo ufw allow $RULE
done
sudo ufw enable

echo "Server configuration completed." 