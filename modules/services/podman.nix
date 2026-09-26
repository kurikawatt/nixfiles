{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.me) services;
in
lib.mkIf services.podman.enable {

  # Common things for containers
  virtualisation.containers = {
    enable = true;
    registries = {
      search = [
        "docker.io" # docker
        "ghcr.io" # github
        "quay.io" # red hat
      ];
      block = [ ];
      insecure = [ ];
    };
  };

  # Podman
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
      flags = [ "--all" ];
    };
  };

  # Podman Compose
  environment.systemPackages = with pkgs; [
    podman-compose
  ];

  # Just to be sure that Docker is not installed
  virtualisation.docker.enable = lib.mkForce false;

  # users.users.${config.me.user}.extraGroups = [ "podman" ];
}