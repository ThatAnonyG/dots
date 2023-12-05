echo "Welcome! Initializing system..."

install_package() {
  echo "Installing $1..."
  if [ -f "/etc/arch-release" ]; then
    sudo pacman -S $1
  fi
}

install() {
  if [ -f "/etc/arch-release" ]; then
    sudo pacman -Syu
  fi
  install_package "git"
  install_package "zsh"
}

flag=$1

if [ "$flag" == "-i" ]; then
  echo "Installing..."
  install()
elif [ "$flag" == "-u" ]; then
  echo "Updating..."
else
  echo "Usage: ./init.sh [OPTION]"
  echo "OPTION:"
  echo "  -h: help"
  echo "  -i: install"
  echo "  -u: update"
  exit 0
fi
