{ config, lib, pkgs, ... }:
{
  imports = [
    ./modules/bundle.nix
  ];

  home = {
    username = "anon";
    homeDirectory = "/home/anon";
    stateVersion = "25.05";
    sessionPath = [
      "${config.home.homeDirectory}/dots/scripts/hyprland"
    ];
  };
}
