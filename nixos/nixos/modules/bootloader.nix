{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.kernelModules = ["amdgpu"];
  boot.kernelParams = [
    "psmouse.synaptics_intertouch=0"
    "amdgpu.aspm=0"
    "amdgpu.runpm=0"
    "amdgpu.bapm=0"
  ];
  boot.extraModprobeConfig = ''
    options usbcore autosuspend=-1
  '';
}
