{pkgs, ...}: {
  environment.systemPackages = with pkgs; [steam gamescope mangohud];
  programs.steam = {
    enable = true;
  };
}
