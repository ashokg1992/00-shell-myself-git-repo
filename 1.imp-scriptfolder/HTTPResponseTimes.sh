
9. HTTP Response Times Script
Script
#!/bin/bash
URLS=("https://www.devopsshack.com/" "https://www.linkedin.com/")
# Check HTTP response times for multiple URLs
for URL in "${URLS[@]}"; do
RESPONSE_TIME=$(curl -o /dev/null -s -w '%{time_total}\n' $URL) echo "Response time for $URL: $RESPONSE_TIME seconds"
done
Explanation
• URLS: An array of URLs to check.

• for URL in "${URLS[@]}" : Iterates over each URL.

• curl -o /dev/null -s -w '%{time_total}\n' $URL: Uses curl to fetch the URL and measure the total response time.

• echo "Response time for $URL: $RESPONSE_TIME seconds" : Prints the response time for each URL.
