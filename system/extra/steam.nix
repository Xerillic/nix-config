{
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [steam gamescope mangohud gamemode];
  programs.steam = {
    enable = true;
    gamescopeSession.enable = lib.mkDefault true;
  };
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
