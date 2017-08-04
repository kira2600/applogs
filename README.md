# applogs
get applogs in docker


For start you need to use parameters.
First parameter – container name;
Second – number of logged strings (default 200). If in case of second parameter used “grep” , will be searched by pattern. You need to indicate pattern like third parameter.

Examples:

/usr/local/etc/get_last_logs/get_logs.sh 4d3
Will be created an archive with 200 last log strings

/usr/local/etc/get_last_logs/get_logs.sh 4d3 10
Will be created an archive with 10 last log strings

/usr/local/etc/get_last_logs/get_logs.sh 4d3 grep “12.22”
Will be created an archive with search result by pattern “12.22”
