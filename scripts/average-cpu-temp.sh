#!/usr/bin/env bash

# Looking for the good hwmon
CPU_HWMON=$(grep -l "coretemp" /sys/class/hwmon/hwmon*/name 2>/dev/null | head -n 1 | xargs dirname)

# Have I found it ?
if [ -z "$CPU_HWMON" ]; then
    echo '{"text": "N/A", "class":"critical"}'
    exit 1
fi

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
    echo '{"text": "N/A", "class":"critical"}'
fi
