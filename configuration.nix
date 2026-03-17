{
  inputs,
  config,
  lib,
  pkgs,
  ...
}: 
{
  # Linux Kernel LTS
  boot.kernelPackages = pkgs.linuxPackages;
  
  # Nix (i use Nix btw)
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
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
  sops.age.sshKeyPaths = [ "/home/kurik/.ssh/id_ed25519" ];

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

  # Don't touch this, please.
  system.stateVersion = "25.11";
}
