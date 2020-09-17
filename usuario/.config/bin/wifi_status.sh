#!/bin/sh

#En esta linea, indicamos EL NOMBRE DE NUESTRA INTERFAZ (según el SO consultar con[ifconfig|iwconfig])
#La variable, quedará conteniendo la IP de dicha interface en caso de existir
IFACE=$(/usr/sbin/ifconfig wlp2s0 | grep "inet " | awk '{print $2}')

#Comprobamos si existe IP en la variable
if [ "$IFACE" != "" ]; then
	echo "%{F#79d7fc} %{F#e2ee6a}$IFACE%{u-}"
else
	echo "" #%{F#79d7fc}%{u-}%{F-}"
fi
