{
  inputs,
  lib,
  ...
}: {
  nixpkgs.config = {
    allowUnfree = lib.mkDefault true;
  };

  nix = {
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
    registry.nixpkgs.flake = inputs.nixpkgs;
    channel.enable = false;

    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
      substituters = [
        "https://cache.nixos.org?priority=10"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      trusted-users = ["root" "@wheel"];
      keep-outputs = true;
      keep-derivations = true;
    };

    gc = {
      automatic = lib.mkDefault true;
      persistent = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  system.autoUpgrade = {
    enable = lib.mkDefault true;
    dates = "03:00";
    flake = "../";
    flags = [
      "--update-input"
      "nixpkgs"
      "--commit-lock-file"
    ];
    allowReboot = false;
  };
}
