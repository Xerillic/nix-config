{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../system
    ../../system/extra/steam.nix
    ./users.nix
  ];

  system.stateVersion = "24.11";
}
