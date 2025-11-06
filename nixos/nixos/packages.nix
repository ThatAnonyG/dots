{ pkgs, pkgs-stable, ... }: {
  environment.systemPackages = with pkgs; [
        # Essential
	zsh
	git
        wget

        # Rice software
	wofi
	waybar

	# Terminals
	kitty

	# Editors
	vim
	neovim

	# Terminal tools
	tmux
	fzf
	eza
	zoxide
	starship
        bat
        delta

        # Build essentials
        pkg-config
    gnumake
    gcc

	# From the stable branch #

	# Browsers
	pkgs-stable.google-chrome
  ];
}
