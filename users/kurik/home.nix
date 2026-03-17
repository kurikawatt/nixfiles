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

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "chord" = {
        hostname = "172.16.195.1";
	user = "kurik";
	port = 22;
	identityFile = "~/.ssh/id_rsa";
      };
      "euphausia" = {
        hostname = "172.16.195.10";
	user = "kurik";
	port = 22;
	identityFile = "~/.ssh/id_rsa";
      };
      "aigis" = {
        hostname = "172.16.195.12";
	user = "kurik";
	port = 22;
	identityFile = "~/.ssh/id_rsa";
      };
      "queen" = {
        hostname = "172.16.195.13";
	user = "kurik";
	port = 22;
	identityFile = "~/.ssh/id_rsa";
      };
    };
  };

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
