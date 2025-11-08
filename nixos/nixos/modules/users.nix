{pkgs, ...}: {
  programs.zsh.enable = true;

  users = {
    defaultUserShell = pkgs.zsh;

    users.anon = {
      isNormalUser = true;
      description = "Anony";
      extraGroups = ["networkmanager" "wheel" "input" "libvirtd"];
    };
  };

  services.getty = {
    autologinUser = "anon";
    loginProgram = "${pkgs.hyprland}/bin/Hyprland";
  };
}
