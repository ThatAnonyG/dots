{
  environment.etc."systemd/sleep.conf".text = ''
    [Sleep]
    HibernateDelaySec=1h
    MemorySleepMode=s2idle
    SuspendState=mem
    HibernateMode=shutdown
  '';
}
