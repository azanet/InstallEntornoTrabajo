#!/bin/bash

##Comprobando que NO se esté Ejecutando como ROOT
if [ "$(whoami)" = "root" ]; then
	echo -e "\n\t\e[1;31mERROR, Don't RUN as\e[0m \e[1;36m\"root\"\e[0m"
	exit 1
fi


#Almacenando Usuario y Grupo primario, se utilizarán para asignar los permisos más alante
USUARIO=$(echo $USER)

USUARIO_HOME=$(pwd)
GRUPO=$(id -gn)
dir_base=$(dirname $(echo $(readlink -f $0))) #tomara el directorio desde donde se ejecuta el script
#dir_base="$dirbase/InstallEntornoTrabajo"


##Removiendo directorios que vamos a instalar por si existen
rm -R -f ~/.config/bin
rm -R -f ~/.config/sxhkd
rm -R -f ~/.config/bspwm
rm -R -f ~/.config/compton
rm -R -f ~/.config/polybar
rm -R -f ~/.tmux
rm -f ~/.tmux.conf.local
rm -R -f  ~/bspwm
rm -R -f ~/sxhkd
sudo rm -R -f /root/.tmux
sudo rm -f /root/.tmux.conf.local
sudo rm -R -f /opt/polybar

#Instalando las dependencias necesarias[bspwm,comton,feh,rofi,tmux,scrub,zsh,plugins-zsh,i3lock]
echo "\nInstalando GIT..."
sudo apt-get install git -y
if [ "$(echo $?)" != "0" ]; then
        echo -e "\e[1;31m\nSe produjo un error, revise las lineas anteriores y vuelva a intentarlo\e[0m"
        exit 1
fi
echo -e "\nGIT Instalado!\n"

echo "\nInstalando 7z..."
sudo apt-get install p7zip-full -y
if [ "$(echo $?)" != "0" ]; then
        echo -e "\e[1;31m\nSe produjo un error, revise las lineas anteriores y vuelva a intentarlo\e[0m"
        exit 1
fi
echo -e "\n7z Instalado!\n"


#######INSTALANDO TMUX ##
echo "\nInstalando TMUX..."
sudo apt-get install tmux -y
if [ "$(echo $?)" != "0" ]; then
        echo -e "\e[1;31m\nSe produjo un error, revise las lineas anteriores y vuelva a intentarlo\e[0m"
        exit 1
fi

#Dopando el Tmux con la config de (https://github.com/gpakosz/.tmux)
cp -r $dir_base/usuario/.tmux ~/.tmux 
ln -s -f ~/.tmux/.tmux.conf
cp -r $dir_base/usuario/.tmux.conf.local ~/.tmux.conf.local
#También para root
sudo cp -r $dir_base/root/.tmux /root/.tmux
sudo ln -s /root/.tmux/.tmux.conf /root/.tmux.conf
sudo cp -r $dir_base/root/.tmux.conf.local /root/.tmux.conf.local
#######FIN DE LA INSTALACION DE tmux ##

echo -e "\nTMUX Instalado!\n"


#######INSTALANDO BSPWM, Dependencias para este agregando configuraciones personalizadas##
echo -e "\nInstalando BSPWM, y sus dependencias..."
sudo apt install bspwm -y
if [ "$(echo $?)" != "0" ]; then
        echo -e "\e[1;31m\nSe produjo un error, revise las lineas anteriores y vuelva a intentarlo\e[0m"
        exit 1
fi

$(sudo apt install dpkg libxcb-xinerama0-dev libxcb-icccm4-dev libxcb-randr0-dev libxcb-util0-dev libxcb-ewmh-dev libxcb-keysyms1-dev libxcb-shape0-dev -y >&~/LOG_DE_ERRORES_INSTALACION.txt)
if [ "$(echo $?)" != "0" ]; then
        echo -e "\e[1;31m\nSe produjo un error, revise las lineas anteriores y vuelva a intentarlo\e[0m"
        exit 1
fi

echo -e "\nClonando, bspwm y sxhkd..."

git clone https://github.com/baskerville/bspwm.git
git clone https://github.com/baskerville/sxhkd.git

echo -e "\nCOMPILANDO e Instalando bspwm y sxhkd..."

cd bspwm && sudo make && sudo make installindice con 
cd ../sxhkd && sudo make && sudo make install
cd
#######FIN DE LA INSTALACION DE bspwm ##
echo -e "\nBSPWM y SXHKD Instalado!\n"


#######INSTALANDO COMPTON, FEH y ROFI ##
echo -e "\nInstalando compton, feh y rofi..."
sudo apt install compton feh rofi -y
if [ "$(echo $?)" != "0" ]; then
        echo -e "\e[1;31m\nSe produjo un error, revise las lineas anteriores y vuelva a intentarlo\e[0m"
        exit 1
fi

echo "\ncompton, feh y rofi Instalado!\n"
#######FIN DE LA INSTALACION DE compton, feh y rofi ##


#######INSTALANDO POLYBAR ##
echo -e "\nInstalando Polybar..."
cd /opt
sudo apt install python-xcbgen
if [ "$(echo $?)" != "0" ]; then
	sudo apt install python3-xcbgen
	if [ "$(echo $?)" != "0" ]; then
        	echo -e "\e[1;31m\nSe produjo un error, revise las lineas anteriores y vuelva a intentarlo\e[0m"
        	exit 1
	fi
fi


sudo apt install build-essential coreutils cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev i3-wm libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev -y
if [ "$(echo $?)" != "0" ]; then
        echo -e "\e[1;31m\nSe produjo un error, revise las lineas anteriores y vuelva a intentarlo\e[0m"
        exit 1
fi

#Descargamos el tar de la Polybar Version 3.4.2 en /opt y descomprimimos
sudo wget https://github.com/polybar/polybar/releases/download/3.4.3/polybar-3.4.3.tar


sudo tar -xf polybar-3.4.3.tar
if [ "$(echo $?)" != "0" ]; then
        echo -e "\e[1;31m\nSe produjo un error, revise las lineas anteriores y vuelva a intentarlo\e[0m"
        exit 1
fi

sudo rm polybar-3.4.3.tar

cd /opt/polybar

sudo mkdir build

cd /opt/polybar/build
sudo cmake ..
if [ "$(echo $?)" != "0" ]; then
        echo -e "\e[1;31m\nSe produjo un error, revise las lineas anteriores y vuelva a intentarlo\e[0m"
        exit 1
fi

sudo make -j$(nproc)
if [ "$(echo $?)" != "0" ]; then
        echo -e "\e[1;31m\nSe produjo un error, revise las lineas anteriores y vuelva a intentarlo\e[0m"
        exit 1
fi

sudo make install
if [ "$(echo $?)" != "0" ]; then
        echo -e "\e[1;31m\nSe produjo un error, revise las lineas anteriores y vuelva a intentarlo\e[0m"
        exit 1
fi

cd
#######FIN DE LA INSTALACION DE polybar ##
echo "\nPolybar Instalada!\n"

##Instalando SCRUB ##
sudo apt install scrub -ysudo chown $USUARIO:$USUARIO -R ~/.config/bin
sudo chown $USUARIO:$USUARIO -R ~/.config/sxhkd
sudo chown $USUARIO:$USUARIO -R ~/.config/bspwm
sudo chown $USUARIO:$USUARIO -R ~/.config/compton
sudo chown $USUARIO:$USUARIO -R ~/.config/polybar
if [ "$(echo $?)" != "0" ]; then
        echo -e "\e[1;31m\nSe produjo un error, revise las lineas anteriores y vuelva a intentarlo\e[0m"
        exit 1
fi
##Fin instalacion SCRUB##

##Instalando Fuente: -Hack Nerd Font- (Se encuentra ya descargada en la carpeta)##
cd /usr/local/share/fonts
sudo cp $dir_base/Hack_Nerd_Font.zip ./

sudo 7z x Hack_Nerd_Font.zip

sudo rm Hack_Nerd_Font.zip
##Fin de instalacion de FUENTE##


##Instalando ZSH y POWERLEVEL10k##
cd
sudo apt install zsh -y
if [ "$(echo $?)" != "0" ]; then
        echo -e "\e[1;31m\nSe produjo un error, revise las lineas anteriores y vuelva a intentarlo\e[0m"
        exit 1
fi

git clone --depth 1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
#echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc

sudo git clone --depth 1 https://github.com/romkatv/powerlevel10k.git /root/powerlevel10k
#echo 'source /root/powerlevel10k/powerlevel10k.zsh-theme' >> /root/.zshrc

##Estableciendo ZSH como shell predeterminada para user y root
RUTA=$(which zsh)

sudo usermod --shell $RUTA $USUARIO

sudo usermod --shell $RUTA root

##FIN de Instalacion de ZSH y POWERLEVEL10k##

##Instalando LSD y BAT (que ya estan descargados)
sudo dpkg -i $dir_base/lsd_0.19.0_amd64.deb

sudo dpkg -i $dir_base/bat_0.15.4_amd64.deb



#Descargando e instalando Plugins de BAT
sudo apt install snapd ripgrep -y
if [ "$(echo $?)" != "0" ]; then
        echo -e "\e[1;31m\nSe produjo un error, revise las lineas anteriores y vuelva a intentarlo\e[0m"
        exit 1
fi

sudo snap install core
if [ "$(echo $?)" != "0" ]; then
        echo -e "\e[1;31m\nSe produjo un error, revise las lineas anteriores y vuelva a intentarlo\e[0m"
        exit 1
fi

sudo snap install shfmt
if [ "$(echo $?)" != "0" ]; then
        echo -e "\e[1;31m\nSe produjo un error, revise las lineas anteriores y vuelva a intentarlo\e[0m"
        exit 1
fi

cd /opt
sudo git clone https://github.com/eth-p/bat-extras.git

cd bat-extras

sudo ./build.sh --install
if [ "$(echo $?)" != "0" ]; then
        echo -e$(cat ~/LOG_DE_ERRORES_INSTALACION.txt)
fi

##FIN de instalacion LSD y BAT##


##Descargando e instalando FZF##
#Para USUARIO
cd
git clone --depth 1 https://github.com/junegunn/fzf.git ~/fzf

./fzf/install
if [ "$(echo $?)" != "0" ]; then
        echo -e "\e[1;31m\nSe produjo un error, revise las lineas anteriores y vuelva a intentarlo\e[0m"
        exit 1
fi

#Para ROOT
sudo git clone --depth 1 https://github.com/junegunn/fzf.git /root/fzf

sudo /root/fzf/install
if [ "$(echo $?)" != "0" ]; then
        echo -e "\e[1;31m\nSe produjo un error, revise las lineas anteriores y vuelva a intentarlo\e[0m"
        exit 1
fi
##Fin del instalacion de FZF ##


##INSTALANDO PLUGINS PARA ZSH##
##Instalando PLUGINS para ZSH (automatico)##
sudo apt install zsh-autosuggestions zsh-syntax-highlighting -y
if [ "$(echo $?)" != "0" ]; then
        echo -e "\e[1;31m\nSe produjo un error, revise las lineas anteriores y vuelva a intentarlo\e[0m"
        exit 1
fi

sudo chown $USUARIO:$USUARIO -R /usr/share/zsh-autosuggestions
sudo chown $USUARIO:$USUARIO -R /usr/share/zsh-syntax-highlighting

##Instalando PLUGINS para ZSH (forma MANUAL)##
sudo mkdir /usr/share/zsh-sudo
sudo wget -O /usr/share/zsh-sudo/sudo.plugin.zsh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/sudo/sudo.plugin.zsh

sudo chown $USUARIO:$USUARIO -R /usr/share/zsh-sudo

##FIN de instalacion PLUGINS##

##Instalando I3LOCKFANCY e imagemagick## (para bloquear pantalla mientras todo sigue corriendo)
sudo apt install i3lock-fancy imagemagick -y
if [ "$(echo $?)" != "0" ]; then
        echo -e "\e[1;31m\nSe produjo un error, revise las lineas anteriores y vuelva a intentarlo\e[0m"
        exit 1
fi

##FIN de instalacion I3FANCY ##



##ULTIMO PASO ANTES DE TERMINAR LA INSTALACION##

##Copiando archivos de Configuracion personalizados de la ZSH y POWERLEVEL10K de los dos usuari$
#Para Usuario
rm ~/.zshrc > /dev/null
cp $dir_base/usuario/.zshrc ~/.zshrc
cp $dir_base/usuario/.p10k.zsh ~/.p10k.zsh

#Para root
sudo rm /root/.zshrc
sudo ln -s $USUARIO_HOME/.zshrc /root/.zshrc
sudo cp $dir_base/root/.p10k.zsh /root/.p10k.zsh

##FINALIZANDO INSTALACION##

##Para finalizar, nos aseguramos de que el usuario sea el propietario de las carpetas creadas
cp -r $dir_base/usuario/.config/* ~/.config/
cp -R $dir_base/usuario/.xinitrc ~/.xinitrc

sudo chown $USUARIO:$USUARIO -R ~/.config/bin
sudo chown $USUARIO:$USUARIO -R ~/.config/sxhkd
sudo chown $USUARIO:$USUARIO -R ~/.config/bspwm
sudo chown $USUARIO:$USUARIO -R ~/.config/compton
sudo chown $USUARIO:$USUARIO -R ~/.config/polybar
sudo chown root:root /usr/local/share/zsh/site-functions/_bspc
chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.config/polybar/launch.sh
chmod +x ~/.config/bin/*
cp -r $dir_base/Logo_Azanet.png ~/

echo -e "\n\n\nINSTALACIÓN FINALIZADA.\n\nDebe dirigirse a la 'Configuracion' de su Terminal\nY establecer 'Hack Nerd Font Mono Regular' como FUENTE Predeterminada."
