#!/bin/bash

# Output file
output_file="email_report.txt"
> "$output_file"

# Get past 7 days in YYYY-MM-DD format
dates=()
for i in {0..6}; do
    dates+=("$(date -d "-$i day" +"%Y-%m-%d")")
done

# Write header
echo "Email Summary Report (Sent & Failed) - Past 7 Days" >> "$output_file"
echo "----------------------------------------------------" >> "$output_file"
echo "" >> "$output_file"

# Loop through each day
for day in "${dates[@]}"; do
    echo "Date: $day" >> "$output_file"
    echo "User         | Sent  | Failed" >> "$output_file"
    echo "-------------|-------|--------" >> "$output_file"

    # Extract relevant lines from exim log
    grep "$day" /var/log/exim_mainlog | grep 'cwd=/home/' > /tmp/exim_tmp.log

    # Get all users for this day
    awk '
        match($0, /cwd=\/home\/([^/]+)/, a) {
            user = a[1]
            if ($0 ~ /<=/) sent[user]++
            if ($0 ~ /\*\*|=\\*\\*/) failed[user]++
        }
        END {
            for (u in sent) {
                printf "%-13s| %-5d | %-6d\n", u, sent[u], failed[u]
            }
            for (u in failed) {
                if (!(u in sent)) {
                    printf "%-13s| %-5d | %-6d\n", u, 0, failed[u]
                }
            }
        }
    ' /tmp/exim_tmp.log | sort >> "$output_file"

    echo "" >> "$output_file"
done

# Cleanup
rm -f /tmp/exim_tmp.log

# Final message
echo "Report generated: $output_file"
