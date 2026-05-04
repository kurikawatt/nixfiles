{ pkgs
, inputs
, config
, lib
, ...
}:
lib.mkIf (config.me.desktop == "hyprland") {
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
  programs.hyprlock.enable = true;

  environment.systemPackages = with pkgs; [
    # term
    kitty
    # file explorer
    yazi
    # top bar
    waybar
    # app launcher
    fuzzel
    # screenshots
    grim
    slurp
    # bluetooth cli control
    bluetuith
    # sound control
    pavucontrol
    # notifications
    mako
    libnotify
    # brightness control on laptop
    brightnessctl
    # volume / brightness feedback on laptop
    swayosd
    # wallpaper
    inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
  ];
}
