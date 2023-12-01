#!/usr/bin/env bash

# Terminate already running bar instances
polybar-msg cmd quit

echo "---" | tee -a /tmp/polybar-top.log

# Set hwmon path
for i in /sys/class/hwmon/hwmon*/temp*_input; do
    if [ "$(<$(dirname $i)/name): $(cat ${i%_*}_label 2>/dev/null || echo $(basename ${i%_*}))" = "nct6798: CPUTIN" ]; then
        export CPU_TEMP_HWMON="$i"
    fi
done

# Launch
polybar top 2>&1 | tee -a /tmp/polybar-top.log & disown
polybar bottom 2>&1 | tee -a /tmp/polybar-bottom.log & disown

echo "Bars launched..."
