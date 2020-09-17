# InstallEntornoTrabajo
Probado en Debian10 y Kali

<p>Ante todo dar créditos e indicar que todo el proceso de instalación 
está basado en dos videos del GRAN "s4vitar" en los cuales
también explica sin ningún desperdicio como manejarse en este entorno:</br>
--Cómo configurar un buen entorno de trabajo en Linux ==> https://www.youtube.com/watch?v=MF4qRSedmEs</br>
--Aprendiendo a usar tmux desde 0 + Tips de Scripting ==> https://www.youtube.com/watch?v=1dDahc214co
 </p>
 
 
Este repositorio contiene los archivos necesarios
para la automatización de la instalación de
un entorno de trabajo para linux estilo "tilling".
Está constituido por "bspwm", "sxhkd", "polybar", "compton", "zsh", "powerlevel10k", "tmux", "i3lock-fancy"
también cuenta con scripts personalizados

INSTALACIÓN
------------
1- Nos situamos en nuestro directorio "HOME"</br>
   $ cd $HOME 

2-Clonar el repositorio </br>
   $ git clone http........

3-Accedemos dentro de la carpeta "InstallEntornoTrabajo" </br>
   $ cd InstallEntornoTrabajo

4-Ejecutamos el archivo "Install.sh" </br>
   $ ./Install.sh

5-Comenzará la instalación, y habrá que interactuar un poco, muy poco..

6-Una vez finalice la instalación, habrá que establecer alguna fuente "Hack Nerd Font" en las "Preferencias" de nuestro "TERMINAL"(consola o como quieran llamarlo).

7-Procedemos a reiniciar el equipo.

8-Al iniciar sesión, deberemos escoger la opción "bspwm" para poder comenzar a utilizar nuestro nuevo entorno de trabajo.

CARPETAS/ARCHIVOS DE CONFIGURACIÓN ¡EN EL SISTEMA!
---------------------------------------------------------------
</br> ~/.config/bspwm/      ===>
</br> ~/.config/sxhkd/      ===>
</br> ~/.config/compton/    ===>
</br> ~/.config/polybar/    ===>
</br> ~/.config/bin/        ===>
</br> ~/.xinitrc        ===>
</br> ~/.zshrc          ===>
</br> ~/.p10k.zsh       ===>
</br> /root/.p10k.zsh   ===>
