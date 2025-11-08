{
  nix.settings.auto-optimise-store = true; # Deduplicate identical files
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  boot.loader.systemd-boot.configurationLimit = 5;
}
