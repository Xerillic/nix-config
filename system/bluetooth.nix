{lib, ...}: {
  hardware.bluetooth = {
    enable = lib.mkDefault true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = lib.mkDefault true;
      };
    };
  };

  services = {
    blueman.enable = lib.mkDefault true;
  };
}
