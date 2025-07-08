{
  description = "NixOS config flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: {
    nixosConfigurations = let
      hosts = builtins.attrNames (builtins.readDir ./hosts);
    in
      builtins.listToAttrs (map (hostName: {
          name = hostName;
          value = nixpkgs.lib.nixosSystem {
            system =
              if builtins.pathExists ./hosts/${hostName}/system.nix
              then (import ./hosts/${hostName}/system.nix).system
              else "x86_64-linux";
            specialArgs = {inherit inputs hostName;};
            modules = [
              ./hosts/${hostName}/configuration.nix
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  extraSpecialArgs = {inherit inputs hostName;};
                };
              }
            ];
          };
        })
        hosts);
  };
}
