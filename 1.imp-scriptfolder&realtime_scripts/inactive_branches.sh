
===================================== ==========================
-  need to have accepts repo name ,username,password,and it should return branches which are in active since last 2/3 months
   - we take git repo anme ,c urrent data, last modified datae, etc we need for this

#!/bin/sh
echo "Enter repo to inactive branches"
read repo_name
echo "Enter username"
read user_name
echo "Enter Password: "
read -s password # read -s password ; whatever we enter password , it should not visible at the time of entering password
presentdate=`date +'%s'`   # to tell time in seconds and  later we convert it into days 
list_of_branches=$(curl -s -u $user_name:$password https://api.github.com/repos/$user_name/$repo_name/branches | jq '.[].name')
for branch in $list_of_branches; do 
api_branch_name=$(echo $branch | cut -d'"' -f 2) # "ashok" = first " is 1st , ashok is 2nd , " is 3rd, i cut 2nd , so -f 2
last_updated_date=$(curl -s -u $user_name:$password https://api.github.com/repos/$user_name/$repo_name/branches/$api_branch_name | jq '.commit.commit.author.date')
api_last_updated_date=$(echo $last_updated_date | cut -d'"' -f 2)
last_updated_date_sec=$(date -d $api_last_updated_date +%s)
numberofdays=$(( ($presentdate - $last_updated_date_sec)/(60*60*24) ))
 if [ $numberofdays -gt 60 ] ; then
        
        echo "Branch $api_branch_name is updated $numberofdays days back"
     fi
done
=============================================================


