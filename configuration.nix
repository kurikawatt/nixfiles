{ 
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  import-tree =
    path:
    let
      inherit (inputs.nixpkgs.lib) fileset hasInfix;
      nixFiles = fileset.toList (fileset.fileFilter (f: f.hasExt "nix") path);
    in
    builtins.filter (p: !(hasInfix "/_" (toString p))) nixFiles;
in
{
  imports = [
    ./users/default.nix
  ]
  ++ (import-tree ./modules)
  ++ (import-tree ./settings);

  # Linux Kernel LTS
  boot.kernelPackages = lib.mkDefault pkgs.linuxPackages;

  # Firmware updates
  services.fwupd.enable = true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # Nix (i use Nix btw)
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [ "kurik" "@wheel" ];
    auto-optimise-store = true;
  };
  programs.nh = {
    enable = true;
    flake = ".";
    clean = {
      enable = true;
      dates = "daily";
      extraArgs = "--keep 5";
    };
  };

  environment.systemPackages = with pkgs; [
    cachix
    age-plugin-tpm
    age
    inputs.magla.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];  

  # Sops
  sops.defaultSopsFile = ./secrets/secrets.json;

  # udisk2
  services.udisks2.enable = true;

  users.mutableUsers = false;

  # Keymaps, Languages & Timezone
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };
  services.xserver.xkb.layout = "fr";
  services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Home manager 
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ config.me.user ];
    };
  };

  programs.direnv = {
    enable = true;
    silent = true;
    enableBashIntegration = true;
  };

  virtualisation.docker.enable = true;

  virtualisation.vmVariant = {

    virtualisation.memorySize = 8192; # 8 Gb of RAM.
    virtualisation.diskSize = 16 * 1024; # 16Gb Disk

    virtualisation.sharedDirectories = {
      ssh_keys = {
        source = "/home/${config.me.user}/.ssh";
        target = "/home/${config.me.user}/.ssh";
      };
    };
  };

  # Don't touch this, please.
  system.stateVersion = "25.11";
}
