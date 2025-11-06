export PATH=/usr/local/go/bin:$PATH
export PATH=$PATH:$HOME/dotfiles/scripts/common
export PATH=$PATH:$HOME/dotfiles/scripts/i3
export PATH=$PATH:$HOME/dotfiles/scripts/polybar
export PATH=$PATH:$HOME/dotfiles/scripts/transmission
export PATH=$PATH:$HOME/dotfiles/scripts/hyprland

# Default terminal
export TERMINAL=st

if [[ "$(tty)" = "/dev/tty1" ]]; then
	pgrep i3 || startx "$HOME/.xinitrc"
fi
