#!/usr/bin/env sh
load=$(uptime | awk -F'[a-z]:' '{ print $2}' | cut -d, -f1)
echo "🖥️  $load |"