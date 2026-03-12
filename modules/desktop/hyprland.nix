{
  pkgs,
  ...
}:
{
  services.displayManager.ly.enable = true;

  programs.hyprland.enable = true;
  programs.hyprlock.enable = true;

  environment.systemPackages = with pkgs; [
    nano
    wget
    tree
    fastfetch
    libnotify
    brightnessctl
    swayosd
    git
  ];
}
