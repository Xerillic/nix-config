# hosts/vessel/configuration.nix - Host sets values for module options
{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../system
    ./users.nix
  ];

  # Direct system configuration (not module options)
  system.stateVersion = "24.11";
}
