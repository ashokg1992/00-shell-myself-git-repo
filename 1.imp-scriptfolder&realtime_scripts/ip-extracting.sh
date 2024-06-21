
 ================ log file - extracting ips- how many times. ======================
#scenario:    i have log file and identify whihc ip is accessing my applicatin and how many times


grep -E -o "([0-9]{1,3}[.\]{3}[0,9]{1,3})" logfile_name | sort | uniq -c | sort -nr
# sort: 
# uniq: to list items unique and skip duplicates items 
# -c: it counts items
# sort -n : it gives increasing order of items 
# sort -nr:
# grep: to exatract particular pattern 


==================================== ============================