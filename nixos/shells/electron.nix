{pkgs}: let
  extraLibs = [
    pkgs.xorg.libXt
    pkgs.xorg.libXtst
    pkgs.xorg.libXi
    pkgs.xorg.libX11
    pkgs.xorg.libXrandr
    pkgs.xorg.libXcomposite
    pkgs.xorg.libXdamage
    pkgs.xorg.libXext
    pkgs.xorg.libXfixes
    pkgs.glib
    pkgs.nss
    pkgs.nspr
    pkgs.dbus
    pkgs.atk
    pkgs.cups
    pkgs.libdrm
    pkgs.gtk3
    pkgs.pango
    pkgs.cairo
    pkgs.libgbm
    pkgs.expat
    pkgs.libxcb
    pkgs.libxkbcommon
    pkgs.alsa-lib
  ];
in
  pkgs.mkShell {
    name = "electron";

    buildInputs =
      [
        pkgs.nodejs_22
        pkgs.electron
        pkgs.nodePackages.typescript
        pkgs.nodePackages.eslint
        pkgs.nodePackages.prettier
        pkgs.nodePackages.nodemon
        pkgs.gtk3
      ]
      ++ extraLibs;

    nativeBuildInputs =
      [
        pkgs.pkg-config
      ]
      ++ extraLibs;

    # THE IMPORTANT PART
    shellHook = ''
      export LD_LIBRARY_PATH=${pkgs.lib.makeLibraryPath extraLibs}:$LD_LIBRARY_PATH
    '';
  }
