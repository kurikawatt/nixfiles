{
  description = "NixOS Kurikawa's Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    };

    awww = {
      url = "git+https://codeberg.org/LGFae/awww";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, sops-nix, ... }@inputs:
  let 
    mkHost =
      name:
        inputs.nixpkgs.lib.nixosSystem rec {
          specialArgs = {
            inherit inputs;
          };
          modules = [
	    inputs.sops-nix.nixosModules.sops
            inputs.home-manager.nixosModules.home-manager
	    ./hosts/${name}/configuration.nix
            {
              networking.hostName = name;
              home-manager.extraSpecialArgs = specialArgs;
	    }
          ];
        };
  in 
  {
    nixosConfigurations = inputs.nixpkgs.lib.genAttrs [
      "aigis"
      "euphausia"      
      "queen"
      "fuuka"
      "metis"
      "chord"
    ] mkHost;
  };
}
