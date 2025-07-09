{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../system
    ./users.nix
  ];

  system.stateVersion = "24.11";
}
