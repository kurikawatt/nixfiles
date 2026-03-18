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
    sops
    udiskie
    jellyfin-desktop

    inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-curses;
  };

  programs.git = {
    enable = true;
    settings.user = {
      name = "François \"Kurikawa\" Odin";
      email = "francois@kurikawa.fr";
    };
    signing = {
      key = "B82830341F5577C0";
      signByDefault = true;
      format = "openpgp";
    };
  };

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
