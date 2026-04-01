{ config
, pkgs
, modulesPath
, ...
}:
{
  imports = [
    ./settings/me.nix

    # guess i have to put this here
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  # programs added to the iso
  environment.systemPackages = with pkgs; [
    neovim
  ];

  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };
  services.xserver.xkb.layout = "fr";
  services.xserver.xkb.options = "eurosign:e,caps:escape";

  nixpkgs.hostPlatform = "x86_64-linux";

  isoImage.contents = [ ];
}
