{
  pkgs,
  pkgs-stable,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # System essentials
    zsh
    git
    wget
    zip
    unzip
    usbutils
    pciutils
    net-tools
    libinput
    lshw
    nautilus
    wev

    # Rice software
    wofi
    brightnessctl
    playerctl
    dunst

    # Terminals
    alacritty
    kitty

    # Editors
    vim
    neovim
    nixd
    alejandra

    # Terminal tools
    tmux
    fzf
    eza
    zoxide
    starship
    bat
    delta
    shfmt
    gopls
    lazygit
    stylua
    black
    ripgrep

    # Build essentials
    pkg-config
    gnumake
    gcc

    # Developer stuff
    nodejs_22
    go

    # NPM Packages
    nodePackages.typescript
    nodePackages.eslint
    nodePackages.prettier
    nodePackages.nodemon

    # From the stable branch #

    # Browsers
    pkgs-stable.google-chrome
  ];

  # Fonts
  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
    font-awesome
    jetbrains-mono

    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];
}
