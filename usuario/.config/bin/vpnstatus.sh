#!/bin/sh

#En esta linea, indicamos EL NOMBRE DE NUESTRA INTERFAZ (según el SO consultar con[ifconfig|iwconfig])
#La variable, quedará conteniendo la IP de dicha interface en caso de existir
IFACE=$(/usr/sbin/ifconfig | grep "tun0" | awk '{print $1}' | tr -d ':')

#Comprobamos si existe IP en la variable
if [ "$IFACE" = "tun0" ]; then
        echo "%{F#1bbf3e} %{F#e2ee6a}$(/usr/sbin/ifconfig tun0 | grep "inet" | awk '{print $2}')%{u-}"
else
        echo "" #%{F#1bbf3e}%{u-}%{F-}"
fi

