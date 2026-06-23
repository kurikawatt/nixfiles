#!/usr/bin/env bash

CPU_HWMON="/sys/class/hwmon/hwmon2"

total=0
count=0

# Loop through all available temperature inputs in your coretemp sensor
for temp_file in $CPU_HWMON/temp*_input; do
    # Ensure the file exists to prevent errors
    if [ -f "$temp_file" ]; then
        temp=$(cat "$temp_file")
        total=$((total + temp))
        count=$((count + 1))
    fi
done

# Calculate the average and convert from millidegrees to standard Celsius
if [ $count -gt 0 ]; then
    avg=$((total / count / 1000))
    
    # Output JSON format so Waybar can easily read it
    echo "{\"text\": \"$avg\"}"
else
    echo "{\"text\": \"N/A\"}"
fi