{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.kernelModules = ["amdgpu"];
  boot.kernelParams = [
    "psmouse.synaptics_intertouch=0"
    "initcall_debug"
    "no_console_suspend"
    "log_buf_len=16M"
    "pm_debug_messages"
    "ignore_loglevel"
  ];
}
