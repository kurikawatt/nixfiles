{ config
, osConfig
, lib
, pkgs
, inputs
, ...
}:
let
  inherit (osConfig) me;
  inherit (osConfig.me) fonts colors;
in
{
  home.stateVersion = "26.05";

  home.file = {
    ".bashrc".source = ../dotfiles/.bashrc;
    "scripts".source = ../scripts;
  };

  xdg = {
    configFile = {
      "swayosd".source = ../dotfiles/swayosd;
      "yazi".source = ../dotfiles/yazi;
      "noctalia".source = ../dotfiles/noctalia;
    };

    userDirs = {
      enable = true;
      createDirectories = true;
      documents = "${me.home}/Documents";
      pictures = "${me.home}/Pictures";
      download = "${me.home}/Downloads";
      extraConfig = {
        SCREENSHOTS = "${me.home}/Screenshots";
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
}
