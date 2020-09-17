#!/bin/sh
STOR=$(/usr/bin/systemctl status tor.service | grep "Active" | awk '{print $2}')

if [ "$STOR" = "active" ]; then
    	echo "%{F#ae34eb}%{F#e2ee6a}"
else
    	echo ""
fi

#ICONOS:  

