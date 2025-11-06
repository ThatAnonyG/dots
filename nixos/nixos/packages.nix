{ pkgs, pkgs-stable, ... }: {
  environment.systemPackages = with pkgs; [
	vim
	kitty
	tmux
	zsh
	wofi
	git
	neovim
	waybar

	# From the stable branch
	pkgs-stable.google-chrome
  ];
}
