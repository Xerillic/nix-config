{lib, ...}: {
  services = {
    udisks2.enable = lib.mkDefault true;
    udev = {
      enable = lib.mkDefault true;
      extraRules = ''
        # Allow users in plugdev group to access USB devices
        SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", GROUP="plugdev", MODE="0664"
      '';
    };
    gvfs.enable = lib.mkDefault true;
    flatpak.enable = lib.mkDefault true;
    fwupd.enable = lib.mkDefault true;
  };
}
