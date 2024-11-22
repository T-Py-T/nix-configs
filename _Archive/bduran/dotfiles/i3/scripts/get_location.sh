#!/usr/bin/env sh
# Fetch location data based on IP address
location=$(curl -s ipinfo.io)

# Extract latitude and longitude
loc=$(echo $location | grep -o '"loc": "[^"]*' | sed 's/"loc": "//')
latitude=$(echo $loc | cut -d ',' -f 1)
longitude=$(echo $loc | cut -d ',' -f 2)

echo "$latitude,$longitude"

