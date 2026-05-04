{ pkgs
, inputs
, ...
}:
{
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

  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  environment.systemPackages = with pkgs; [
    # term
    kitty
    # file explorer
    yazi
    # screenshots
    grim
    slurp
    # bluetooth cli control
    bluetuith
    # sound control
    pavucontrol
    # notifications
    brightnessctl
    # volume / brightness feedback on laptop
    inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
