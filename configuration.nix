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
    ./networks/wg-fuuka0.nix
  ]
  ++ (import-tree ./modules/services);

  # Linux Kernel LTS
  boot.kernelPackages = pkgs.linuxPackages;

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

  hardware.bluetooth.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # Cachix
  environment.systemPackages = with pkgs; [
    cachix
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

  services.openssh.enable = true;

  virtualisation.vmVariant = {
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
