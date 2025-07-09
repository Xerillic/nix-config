{...}: {
  imports = [
    ./nix.nix
    ./boot.nix
    ./audio.nix
    ./desktop.nix
    ./services.nix
    ./security.nix
    ./networking.nix
    ./environment.nix
  ];
}
