{...}: {
  imports = [
    ./nix.nix
    ./boot.nix
    ./audio.nix
    ./desktop.nix
    ./security.nix
    ./services.nix
    ./bluetooth.nix
    ./networking.nix
    ./environment.nix
  ];
}
