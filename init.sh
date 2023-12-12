echo "Welcome! Initializing system..."

install_package() {
  echo "Installing $1..."
  if [ -f "/etc/arch-release" ]; then
    sudo pacman -S $1
  else
    echo "Unsupported OS!"
    exit 1
  fi
}

install_package_paru() {
  echo "Installing $1..."
  paru -S $1
}

create_symlinks() {
  dotfiles_dir=~/dotfiles

  echo "Creating symlinks from $dotfiles_dir..."
  mkdir -p ~/.config

  # ZSH symlinks
  ln -sf $dotfiles_dir/.zshrc ~/.zshrc
  ln -sf $dotfiles_dir/.zshenv ~/.zshenv
  ln -sf $dotfiles_dir/.zprofile ~/.zprofile

  # Git symlinks
  ln -sf $dotfiles_dir/.gitconfig ~/.gitconfig

  # X symlinks
  ln -sf $dotfiles_dir/.Xresources ~/.Xresources
  ln -sf $dotfiles_dir/.xinitrc ~/.xinitrc

  # Vim/Neovim symlinks
  ln -sf $dotfiles_dir/.vimrc ~/.vimrc
  ln -sf $dotfiles_dir/nvim ~/.config/nvim

  # Terminal related symlinks
  ln -sf $dotfiles_dir/tmux ~/.config/tmux
  ln -sf $dotfiles_dir/starship.toml ~/.config/starship.toml
  ln -sf $dotfiles_dir/alacritty ~/.config/alacritty

  # i3 symlinks
  ln -sf $dotfiles_dir/i3 ~/.config/i3

  # Dunst symlinks
  ln -sf $dotfiles_dir/dunst ~/.config/dunst

  # Polybar symlinks
  ln -sf $dotfiles_dir/polybar ~/.config/polybar

  # Picom symlinks
  ln -sf $dotfiles_dir/picom ~/.config/picom

  # Neofetch symlinks
  ln -sf $dotfiles_dir/neofetch ~/.config/neofetch
}

install() {
  echo "Installing packages..."

  if [ -f "/etc/arch-release" ]; then
    sudo pacman -Syu
    echo "Installing paru..."
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si
  fi

  # todo all packages
}

flag=$1

if [ "$flag" == "-i" ]; then
  echo "Installing..."
  create_symlinks
elif [ "$flag" == "-u" ]; then
  echo "Updating (todo)..."
else
  echo "Usage: ./init.sh [OPTION]"
  echo "OPTION:"
  echo "  -h: help"
  echo "  -i: install"
  echo "  -u: update"
  exit 0
fi
