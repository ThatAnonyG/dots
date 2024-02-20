picom --config="$HOME/.config/picom/picom.conf" &
dunst -conf "$HOME/.config/dunst/dunstrc" &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
nitrogen --restore &

xrdb -load ~/.Xresources

transmission-daemon &
blueman-applet &
nextcloud &
flameshot &

dbus-update-activation-environment --systemd DISPLAY

exec i3
