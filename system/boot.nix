{pkgs, ...}: {
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        consoleMode = "auto";
        configurationLimit = 8;
      };
    };
    tmp.cleanOnBoot = true;
    kernelPackages = pkgs.linuxPackages_zen;

    kernelParams = [
      "quiet"
      "splash"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "boot.shell_on_fail"
    ];
  };
}
