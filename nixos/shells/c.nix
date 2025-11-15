{pkgs}:
pkgs.mkShell {
  name = "c-shell";
  buildInputs = with pkgs; [
    glib
    glibc
    gcc
    gnumake
    cmake
    meson
    ninja
    innoextract

    glib.out
    glib.dev
    libfprint
    libfprint.out
    libfprint-tod
    libjson

    # Development Libraries
    openssl.dev
    libusb1.dev
    libcap.dev
    libseccomp.dev
    dbus.dev
    gusb.dev
  ];
  nativeBuildInputs = with pkgs; [
    pkg-config
  ];
}
