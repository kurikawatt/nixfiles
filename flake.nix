{
  description = "NixOS Kurikawa's Configuration";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    awww = {
      url = "git+https://codeberg.org/LGFae/awww";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    magla = {
      url = "git+https://codeberg.org/kurikawa/magla";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mangowm = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, sops-nix, disko, mangowm, nixos-hardware, ... }@inputs:
    let
      mkHost =
        name:
        inputs.nixpkgs.lib.nixosSystem rec {
          specialArgs = {
            inherit inputs;
          };
          modules = [
            sops-nix.nixosModules.sops
            disko.nixosModules.disko
            mangowm.nixosModules.mango
            inputs.home-manager.nixosModules.home-manager
            ./hosts/${name}/configuration.nix
            {
              networking.hostName = name;
              home-manager.extraSpecialArgs = specialArgs;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              nixpkgs.config.allowUnfree = true;
            }
          ];
        };
    in
    {
      nixosConfigurations =
        (inputs.nixpkgs.lib.genAttrs [
          "aigis"
          "euphausia"
          "queen"
          "fuuka"
          "metis"
          "chord"
          "violet"
        ]
          mkHost)
        // {
          iso = inputs.nixpkgs.lib.nixosSystem {
            specialArgs = {
              inherit inputs;
            };
            modules = [
              disko.nixosModules.disko
              ./iso.nix
            ];
          };
        };
    };
}
