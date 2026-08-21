{ config
, osConfig
, lib
, pkgs
, inputs
, ...
}:
let
  import-tree =
    path:
    let
      inherit (inputs.nixpkgs.lib) fileset hasInfix;
      nixFiles = fileset.toList (fileset.fileFilter (f: f.hasExt "nix") path);
    in
    builtins.filter (p: !(hasInfix "/_" (toString p))) nixFiles;

    inherit (osConfig) me;
    inherit (osConfig.me) colors;
    inherit (osConfig.me.services.fuuka) peers;
in
{
  imports = [ ./waybar/waybar.nix ]
  ++ (import-tree ./programs);

  home.stateVersion = "26.05";

  home.file = {
    ".bashrc".source = ../dotfiles/.bashrc;
    "scripts".source = ../scripts;
  };

  xdg = {
    configFile = {
      "swayosd".source = ../dotfiles/swayosd;
      "yazi".source = ../dotfiles/yazi;
      "mango".source = ../dotfiles/mango;
    };

    userDirs = {
      enable = true;
      createDirectories = true;
      setSessionVariables = true;
      documents = "${me.home}/Documents";
      pictures = "${me.home}/Pictures";
      download = "${me.home}/Downloads";
      extraConfig = {
        SCREENSHOTS_DIR = "${me.home}/Screenshots";
      };
    };
  };  

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
  };

  # --- Usefull tools ---
  programs = {
    ssh = {
      enable = true;
      settings = lib.mapAttrs
      (name: peerInfo: {
        HostName = peerInfo.ipv4;
        User = osConfig.me.user;
        Port = 22;
      })
      peers;
    };

    gpg.enable = true;

    git = {
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
      settings.alias = {
        cm = "commit";
        st = "status";
      };
    };
  };

  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-curses;
  };

  # --- Services --
  services.udiskie.enable = true;

  # --- Apps ---
  programs = {
    neovim.enable = true;
    
    vscodium = {
      enable = true;
      profiles.default.extensions = with pkgs.vscode-extensions; [
        enkia.tokyo-night
        ms-python.python
        jnoortheen.nix-ide
      ];
    };
  };

  home.packages = with pkgs; [
    vesktop
    obsidian
    thunderbird
    sops
    jellyfin-desktop
    gh
    bluetuith
    nixd
    nixpkgs-fmt
    deezer-enhanced
    azahar
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ]
  ++ (
    if osConfig.networking.hostName == "queen" 
    then [
      deluge
      gimp
      archipelago
      poptracker
      prismlauncher
    ] else []
  );
}