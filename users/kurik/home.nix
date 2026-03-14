{
  lib,
  pkgs,
  inputs,
  ...
}:
let 
  homeDir = "/home/kurik";
in
{
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    mako
    kitty
    firefox
    waybar
    fuzzel
    grim
    slurp
    vesktop
    neovim
    obsidian
    thunderbird
    bluetuith
    pavucontrol

    inputs.awww.packages.${system}.awww
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  xdg.userDirs = {
    enable = true;
    createDirectories = true; # ONLY if not already created
    
    documents = "${homeDir}/Documents";
    pictures = "${homeDir}/Pictures";
    download = "${homeDir}/Downloads";

    extraConfig = {
      SCREENSHOTS_DIR = "${homeDir}/Screenshots";
    };
  };
}
