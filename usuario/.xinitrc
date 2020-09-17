#estableciendo configuracion para pantalla
#xrandr --output eDP-1 --mode 1366x768 --rotate normal --output DP-1 --off --output HDMI-1 --off --output HDMI-2 --primary --mode 1920x1080i --left-of eDP-1 --rotate normal
#Lanzando Window Manager y Shortcuts
sxhkd &
exec bspwm



