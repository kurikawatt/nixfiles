{ pkgs
, inputs
, config
, lib
, ...
}:
lib.mkIf (config.me.desktop == "mango") {
  services.displayManager.ly.enable = true;

  programs.mango.enable = true;

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
  ];
}
