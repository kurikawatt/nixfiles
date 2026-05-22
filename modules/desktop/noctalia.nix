{ pkgs
, inputs
, config
, lib
, ...
}:
lib.mkIf (config.me.desktop == "noctalia") {
  services.displayManager.ly.enable = true;

  nix.settings = {
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
  };

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
  };

  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    # term
    kitty
    # file explorer
    yazi
    # screenshots
    grim
    slurp
    # for gsettings
    glib
    gsettings-desktop-schemas

    inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  # audio routing for Discord Screenshare / Steam Remote Play
  security.rtkit.enable = true;
}
