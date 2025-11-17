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
    wev
    procps
    libnotify
    dmidecode
    polkit_gnome
    xhost
    libglvnd
    mesa-demos

    # Good software
    gparted
    nautilus
    networkmanagerapplet
    pavucontrol
    nextcloud-client
    bitwarden-desktop

    # Rice software
    wofi
    brightnessctl
    playerctl
    dunst
    hyprlock
    hypridle
    hyprpaper

    # Terminals
    alacritty
    kitty

    # Editor stuff
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
    glibc
    cmake

    # Developer stuff
    python313
    nodejs_22
    go
    rustup
    nixd
    alejandra

    # Python Packages
    python313Packages.pip

    # NPM Packages
    nodePackages.typescript
    nodePackages.eslint
    nodePackages.prettier
    nodePackages.nodemon

    # From the stable branch #

    pkgs-stable.google-chrome
    pkgs-stable.discord
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
