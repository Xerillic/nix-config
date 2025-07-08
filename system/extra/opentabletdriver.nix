{pkgs, ...}: {
  hardware.opentabletdriver = {
    enable = true;
    package = pkgs.opentabletdriver;
    daemon.enable = true;
    blacklistedKernelModules = [
      "hid-uclogic"
      "wacom"
    ];
  };
}
