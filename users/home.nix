{ config
, osConfig
, lib
, pkgs
, inputs
, ...
}:
let
  homeDir = "/home/kurik";

  import-tree =
    path:
    let
      inherit (inputs.nixpkgs.lib) fileset hasInfix;
      nixFiles = fileset.toList (fileset.fileFilter (f: f.hasExt "nix") path);
    in
    builtins.filter (p: !(hasInfix "/_" (toString p))) nixFiles;
in
{
  imports = []
  ++ (import-tree ./waybar);

  home.stateVersion = "26.05";

  home.file = {
    ".bashrc".source = ../dotfiles/.bashrc;
    "scripts".source = ../scripts;
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
    config.common.default = "*";
  };

  xdg.configFile = {
    "swayosd".source = ../dotfiles/swayosd;
    "yazi".source = ../dotfiles/yazi;
    "mango".source = ../dotfiles/mango;
  };

  programs.ssh.matchBlocks = {
    "chord" = {
      hostname = "172.16.195.1";
      user = "kurik";
      port = 22;
      identityFile = "~/.ssh/id_rsa";
    };
    "metis" = {
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

  services.udiskie.enable = true;

  home.packages = with pkgs; [
    tree
    fastfetch
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

    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ]
  ++ (
    if osConfig.networking.hostName == "queen" 
    then [
      deluge
      gimp
      archipelago
      poptracker
    ] else []
  );

  programs.neovim = {
    enable = true;
  };

  programs.vscodium = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      enkia.tokyo-night
      ms-python.python
      jnoortheen.nix-ide
    ];
  };

  programs.obs-studio = {
    enable = true;

    # Nvidia hardware acceleration
    package = (
      pkgs.obs-studio.override {
        cudaSupport = (if osConfig.networking.hostName == "queen" then true else false);
      }
    );

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-gstreamer
      obs-vkcapture
    ];
  };

  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-curses;
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
    settings.alias = {
      cm = "commit";
      st = "status";
    };
  };

  programs.waybar = {
    enable = true;
    settings = {
      main = {
        layer = "bottom";
        position = "top";
        spacing = 0;
        height = 0;
        reload_style_on_change = true;
        modules-left = [ "custom/hostname" ];
        modules-center = [ "clock" ];
        modules-right = [ "wireplumber" ];
        "custom/hostname" = {
          format = "{}";
          exec = "cat /etc/hostname";
        };
        "wireplumber" = {
          format = " vol : {volume}%";
          format-muted = "vol : muted";
          nospacing = 1;
          scroll-step = 1;
        };
      };
    };
    style =
      ''
        * {
          border: none;
          border-radius: 0;
          min-height: 0;
          font-family: Cascadia Code;
          font-size: 16px;
        }

        window#waybar {
          background-color: #${osConfig.me.colors.background};
        }

        #clock,
        #custom-hostname,
        #wireplumber {
          margin: 5px;
          padding: 6px 12px;
        }

        #custom-hostname {
          color: #ECE14B;
        }

        #clock,
        #wireplumber {
          color: #${osConfig.me.colors.foreground};
        }

        tooltip {
          background-color: #${osConfig.me.colors.background};
        }

        tooltip label {
          padding: 10px;
          background-color: #${osConfig.me.colors.background};
        }
      '';
  };

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        layout = "overlay";
        font = "Cascadia Code:size=14";
        terminal = "${pkgs.foot}/bin/foot";
        enable-mouse = false;
        icons-enabled = false;
      };
      border = {
        width = 2;
        radius = 0;
      };
      colors = {
        background = "#${osConfig.me.colors.background}ff";
        text = "#${osConfig.me.colors.foreground}ff";
        prompt = "#${osConfig.me.colors.foreground}ff";
        placeholder = "#6e6a86ff";
        input = "#${osConfig.me.colors.foreground}ff;";
        match = "#${builtins.elemAt osConfig.me.colors.regulars 4}ff";
        selection = "#403d52ff";
        selection-text = "#${osConfig.me.colors.foreground}ff";
        selection-match = "#ebbcbaff";
        counter = "#f6c177ff";
        border = "#ec4067ff";
      };
    };
  };

  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      font-size = 24;
      indicator-idle-visible = false;
      show-failed-attempts = false;

      indicator-x-position = 960;
      indicator-y-position = 900;

      # Background color
      color = "#191724";
      image = "~/Pictures/wallpapers/Abso/abso_eupha_night.jpg";
      scaling = "fill";
      effect-blur = "7x5";

      # Layout text colors
      layout-bg-color = "#00000000";
      layout-border-color = "#00000000";
      layout-text-color = "#e0def4";

      # Text color
      text-color = "#31748f00";
      text-clear-color = "#9ccfd800";
      text-caps-lock-color = "#f6c17700";
      text-ver-color = "#c4a7e700";
      text-wrong-color = "#eb6f9200";

      # Highlight segments
      bs-hl-color = "#19172466";
      key-hl-color = "#31748f";
      caps-lock-bs-hl-color = "#19172466";
      caps-lock-key-hl-color = "#f6c177";

      # Highlight segments separator
      separator-color = "#00000000";

      # Inside of the indicator
      inside-color = "#31748f55";
      inside-clear-color = "#9ccfd855";
      inside-caps-lock-color = "#f6c17755";
      inside-ver-color = "#c4a7e755";
      inside-wrong-color = "#eb6f9255";

      # Line between the inside and ring
      line-color = "#31748f11";
      line-clear-color = "#9ccfd811";
      line-caps-lock-color = "#f6c17711";
      line-ver-color = "#c4a7e711";
      line-wrong-color = "#eb6f9211";

      # Indicator ring
      ring-color = "#31748faa";
      ring-clear-color = "#9ccfd8aa";
      ring-caps-lock-color = "#f6c177aa";
      ring-ver-color = "#c4a7e7aa";
      ring-wrong-color = "#eb6f92aa";

    };
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true; # ONLY if not already created
    setSessionVariables = true;

    documents = "${homeDir}/Documents";
    pictures = "${homeDir}/Pictures";
    download = "${homeDir}/Downloads";

    extraConfig = {
      SCREENSHOTS_DIR = "${homeDir}/Screenshots";
    };
  };

  services.mako = {
    enable = true;
    settings = {
      layer = "overlay";
      anchor = "top-center";
      width = 512;
      height = 256;
      margin = 10;
      padding = 24;
      font = "Cascadia Code 12";
      text-color = "#${osConfig.me.colors.foreground}";
      background-color = "#${osConfig.me.colors.background}";
      border-color = "#ec4067";
      default-timeout = 2500;
      "urgency=critical" = {
        default-timeout = 0;
      };
    };
  };
}
