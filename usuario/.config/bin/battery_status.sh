#!/bin/sh

RESULT=$(upower -i /org/freedesktop/UPower/devices/battery_BAT1 2>&1)

if [ "$?" != "0" ]; then
	echo "%{F#cf0000}%{F#e2ee6a}%{u-}"

else

	STATE=$(echo "$RESULT" | grep "state" | awk '{print $2}')
	CHARGE=$(echo "$RESULT" | grep "percentage" | awk '{print $2}')
	CHARGENUM=$(echo $CHARGE | tr -d '%')

	if [ "$STATE" = "charging" ]; then


		if [ "$CHARGENUM" -lt "98" ]; then
			echo "%{F#36ff8d} %{F#e2ee6a}$CHARGE%{u-}"
		else
                	echo "%{F#18f714}%{F#e2ee6a}%{u-}"
		fi


	elif [ "$STATE" = "discharging" ]; then

                if [ "$CHARGENUM" -gt "50" ]; then
	                echo "%{F#ffd414} %{F#e2ee6a}$CHARGE%{u-}"

		elif [ "$CHARGENUM" -gt "15" ]; then
                        echo "%{F#f56a07} %{F#e2ee6a}$CHARGE%{u-}"

                else
                        echo "%{F#cf0000} %{F#e2ee6a}$CHARGE%{u-}"

		fi

	elif [ "$STATE" = "fully-charged" ]; then
                echo "%{F#18f714}%{F#e2ee6a}%{u-}"

	fi


fi


# echo "%{F#2495e7} %{F#e2ee6a}$IFACE%{u-}"
