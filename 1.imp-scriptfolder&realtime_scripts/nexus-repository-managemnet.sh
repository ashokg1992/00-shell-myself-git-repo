============================ 1-nexus management=============================

- scenario:
    - interacting with nexus repositories using nexus apis, jq for json handling, list number of repositories, list host repositories, proxy repositories with URLs,  and like admin related activities like creating  repositories by using script,  etc
# - theree types of repositories in nexus:
#     - host
#     -gropup
#     - proxy repo
# script report.sh is designed to interact with Nexus repositories using Nexus APIs and jq for JSON handling.

# It can count the total number of repositories, list hosted repositories, and list proxy repositories with their remote URLs.

# The script helps automate administrative tasks, such as creating Maven repositories, to reduce human errors during configuration.

# Automation ensures consistent configurations, preventing potential issues from manual setup mistakes.

# Command Examples:
# --------------------------------
# Running report.sh count outputs the number of repositories.
# Running report.sh hosted lists all hosted repositories.
# Running report.sh proxy lists all proxy repositories along with their remote URLs.

# Usage of Nexus APIs and jq:
# -----------------------------
# Nexus APIs are used to fetch repository information, which is returned in JSON format.
# jq is used to parse and filter JSON data to extract relevant information like repository names or types.

# Error Handling and User Guidance:
# ----------------------------------
# The script includes error handling to guide users if incorrect or no arguments are provided.
# It provides help messages and sets a non-zero exit status for incorrect usage, improving user experience and script reliability.




#! /bin/sh
# by deeskish sn.

help(){
    echo "the way you exected script is wrong "
    echo "the script options are count, hosted and proxy"
    echo "example to run this script sh nexus-report.sh count"
    exit 137
}

if [ "$1" = "count"  ]   # if our argument is  count then it exectues 
then
curl -s -X  'GET' 'http://nexus-ip:8081/service/rest/v1/repositories' -H 'accept: application/json' | jq .[].name | wc -l      
elif  [ "$1" = "hosted" ]
then
    echo "Repo Name"
    curl -s -X  'GET' 'http://nexus-ip:8081/service/rest/v1/repositories' -H 'accept: application/json'  | jq ' .[] | select ( .type == "hosted" ) | .name ' | sed 's/"//g'   # select query in json is used to fetch specific key type data
elif [ "$1" = "proxy" ]
then
    echo "Repo Name, Remote URL"
    curl -s -X  'GET' 'http://nexus-ip:8081/service/rest/v1/repositories' -H 'accept: application/json' | jq ' .[] | select ( .type == "proxy" ) | .name + "," + .attributes.proxy.remoteUrl ' | sed 's/"//g'   # + = concatanation 
elif [[ "$1" = "admin" && "$2" = "mrc" ]]
then
 echo "please enter maven repo name"
 read repo
 sed -i "s/REPONAME/$repo/g" maven.json
 curl -s -H "Content-Type: application/json" -u admin:admin -d @maven.json 'http://nexus-ip:8081/service/rest/v1/repositories/maven/hosted'
    if [ $? -eq 0 ]
    then 
        echo "the repo creation succesful "
    else
        echo "repo creation failed"
    fi
 sed -i "s/$repo/REPONAME/g" maven.json
else
 help    # it calls the above " help "" function 
fi