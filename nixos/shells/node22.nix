{pkgs}: let
  extraLibs = [];
in
  pkgs.mkShell {
    name = "node22";

    buildInputs =
      [
        pkgs.nodejs_22

        pkgs.nodePackages.typescript
        pkgs.nodePackages.eslint
        pkgs.nodePackages.prettier
        pkgs.nodePackages.nodemon
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
