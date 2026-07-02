{ inputs
, config
, lib
, pkgs
, ...
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
    ./settings/me.nix
    ./users/default.nix
  ]
  ++ (import-tree ./modules);

  # Linux Kernel LTS
  boot.kernelPackages = lib.mkDefault pkgs.linuxPackages;

  # Firmware updates
  services.fwupd.enable = true;

  # Nix (i use Nix btw)
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [ "kurik" "@wheel" ];
    auto-optimise-store = true;

    substituters = [
      "http://172.16.195.2:8080"
      "https://cache.nixos.org"
    ];

    trusted-public-keys = [
      "compendium:sUVIH8kmLdxpo5pTLnlSaOcR/dNP4dTjDwanQFOKYV4="
    ];

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

  # Enable NetworkManager
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
      };
    };
  };

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # Cachix
  environment.systemPackages = with pkgs; [
    cachix
    age-plugin-tpm

    clamav

    attic-client

    inputs.magla.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  # Clamav
  services.clamav.daemon.enable = true;
  services.clamav.updater.enable = true;

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
