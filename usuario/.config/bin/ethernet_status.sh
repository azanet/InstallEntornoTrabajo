#!/bin/sh

#En esta linea, indicamos EL NOMBRE DE NUESTRA INTERFAZ (según el SO consultar con[ifconfig|iwconfig])
#La variable, quedará conteniendo la IP de dicha interface en caso de existir
IFACE=$(/usr/sbin/ifconfig enp1s0f1 | grep "inet " | awk '{print $2}')

#Comprobamos si existe IP en la variable
if [ "$IFACE" != "" ]; then
        echo "%{F#2495e7} %{F#e2ee6a}$IFACE%{u-}"
else
        echo "" #%{F#2495e7}%{u-}%{F-}"
fi


