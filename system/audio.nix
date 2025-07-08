{
  lib,
  pkgs,
  ...
}: {
  hardware.bluetooth = {
    enable = lib.mkDefault true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = lib.mkDefault true;
      };
    };
  };

  security.rtkit.enable = lib.mkDefault true;
  services.pipewire = {
    enable = lib.mkDefault true;
    alsa.enable = lib.mkDefault true;
    alsa.support32Bit = lib.mkDefault true;
    pulse.enable = lib.mkDefault true;
    jack.enable = lib.mkDefault true;
    wireplumber = {
      enable = lib.mkDefault true;
      extraConfig = {
        "10-disable-camera" = {
          "wireplumber.profiles" = {
            main."monitor.libcamera" = "disabled";
          };
        };
        "11-bluetooth-policy" = {
          "wireplumber.settings" = {
            "bluetooth.autoswitch-to-headset-profile" = false;
          };
        };
      };
    };
  };

  services = {
    pulseaudio.enable = lib.mkDefault false;
    blueman.enable = lib.mkDefault true;
  };
  environment.systemPackages = with pkgs; [
    pavucontrol
  ];
}
