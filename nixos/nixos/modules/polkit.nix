{
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (subject.isInGroup("users") &&
          (action.id == "net.reactivated.fprint.device.enroll" ||
           action.id == "net.reactivated.fprint.device.verify" ||
           action.id == "net.reactivated.fprint.device.identify")) {
        return polkit.Result.YES;
      }
    });
  '';
}
