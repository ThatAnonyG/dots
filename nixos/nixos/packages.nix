{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    vim
    kitty
    tmux
    zsh
    wofi
    git
    google-chrome
    neovim
    waybar
  ];
}
