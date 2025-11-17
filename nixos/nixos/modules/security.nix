{pkgs, ...}: {
  services.gnome.gnome-keyring.enable = true;
  services.dbus.packages = [pkgs.gnome-keyring pkgs.gcr];
  programs.seahorse.enable = true;
  security.pam.services = {
    login.fprintAuth = true;
    sudo.fprintAuth = true;
    polkit-1.fprintAuth = true;
    hyprlock.fprintAuth = true;
    login.enableGnomeKeyring = true;
    hyprland.enableGnomeKeyring = true;
  };
}
