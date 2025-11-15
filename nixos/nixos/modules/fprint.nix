{
  pkgs,
  inputs,
  ...
}: let
  synaTudorPkg = pkgs.callPackage inputs.synaTudor {};
in {
  systemd.packages = [synaTudorPkg];
  services.udev.packages = [synaTudorPkg];
  services.dbus.packages = [synaTudorPkg];
  environment.systemPackages = [synaTudorPkg];

  services.fprintd.enable = true;
  services.fprintd.tod.enable = true;
  services.fprintd.tod.driver = synaTudorPkg;

  security.pam.services = {
    login.fprintAuth = true;
    sudo.fprintAuth = true;
    polkit-1.fprintAuth = true;
    hyprlock.fprintAuth = true;
  };
}
