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

<<<<<<< HEAD
  programs.dconf.enable = true;

=======
>>>>>>> 2569b91af8be3ffa138d672a38f750607a7db1b8
  environment.systemPackages = with pkgs; [
    # term
    kitty
    # file explorer
    yazi
    # screenshots
    grim
    slurp
<<<<<<< HEAD
    # for gsettings
    glib
    gsettings-desktop-schemas
=======
>>>>>>> 2569b91af8be3ffa138d672a38f750607a7db1b8

    inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
