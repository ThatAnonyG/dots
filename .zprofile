export PATH=/usr/local/go/bin:$PATH
export PATH=$PATH:$HOME/dotfiles/scripts/common
export PATH=$PATH:$HOME/dotfiles/scripts/i3
export PATH=$PATH:$HOME/dotfiles/scripts/polybar
export PATH=$PATH:$HOME/dotfiles/scripts/transmission
export PATH=$PATH:$HOME/dotfiles/scripts/hyprland
export PATH=$PATH:$HOME/dotfiles/scripts/waybar

if [[ "$(tty)" = "/dev/tty1" ]]; then
  # Now depends whether we are running NixOS or not
  if [ -f /etc/NIXOS ]; then
    pgrep hyprland || dbus-run-session Hyprland
  else
    # Default terminal
    export TERMINAL=st
	  pgrep i3 || startx "$HOME/.xinitrc"
  fi
fi
