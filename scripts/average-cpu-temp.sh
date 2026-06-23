#!/usr/bin/env bash

CPU_HWMON="/sys/class/hwmon/hwmon2"

total=0
count=0

critical_threshold=80

for temp_file in $CPU_HWMON/temp*_input; do

    if [ -f "$temp_file" ]; then
        temp=$(cat "$temp_file")
        total=$((total + temp))
        count=$((count + 1))
    fi
done

if [ $count -gt 0 ]; then
    avg=$((total / count / 1000))
    
    if [ "$avg" -ge "$critical_threshold" ]; then
        echo "{\"text\": \"$avg\", \"class\": \"critical\"}"
    else
        echo "{\"text\": \"$avg\", \"class\": \"normal\"}"
    fi

else
    echo "{\"text\": \"N/A\"}"
fi