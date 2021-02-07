#!/bin/bash

# Terminate already running bar instances
#killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

############################
  if type "xrandr"; then
    for m in $(xrandr --listactivemonitors | grep -v "^Monit*" | awk '{print $4}'); do
      MONITOR=$m polybar example &
      sleep 1
    done
  else
    polybar example &
  fi

# Launch bar1 and bar2
#polybar example &

# echo "Polybars launched..."

