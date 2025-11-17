{pkgs, ...}: {
  environment.etc."systemd/sleep.conf".text = ''
    [Sleep]
    HibernateDelaySec=1h
    MemorySleepMode=s2idle
    SuspendState=mem
    HibernateMode=shutdown
  '';

  environment.etc."systemd/system-sleep/hibernate-fix.sh" = {
    text = ''
      #!/bin/sh

      format="+%Y-%m-%dT%H:%M:%S.%N%:z"
      WiFiModule=rtw89_8852ae

      echo "[$(${pkgs.coreutils}/bin/date $format)] HOOK: Running script..." >> /var/log/sleep-debug.log

      case "$1 $2" in
        "pre suspend" | "pre hibernate" | "pre suspend-then-hibernate")
          echo "[$(${pkgs.coreutils}/bin/date $format)] PRE: Unloading WiFi module $WiFiModule" >> /var/log/sleep-debug.log
          ${pkgs.kmod}/bin/modprobe -r $WiFiModule
          ;;
        "post suspend" | "post hibernate" | "post suspend-then-hibernate")
          echo "[$(${pkgs.coreutils}/bin/date $format)] POST: Loading WiFi module $WiFiModule" >> /var/log/sleep-debug.log
          ${pkgs.kmod}/bin/modprobe $WiFiModule
          ;;
        *)
          :
          ;;
      esac
    '';
    mode = "0755";
  };
}
