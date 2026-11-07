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
    inherit (osConfig.me) fonts colors;
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

  # --- Mango ---
  wayland.windowManager.mango = {
    enable = true;
    autostart_sh = ''
      foot --server & 
      noctalia
    '';
    settings = {
      # Mess
      sync_obj_enable = if osConfig.me.host.gpuType == "nvidia" then 1 else 0;
      
      # Keyboard
      xkb_rules_layout = "fr";
      numlock_on = 1;
      
      # Navigation
      trackpad_natural_scrolling = 1;
      mouse_natural_scrolling = 0;
      
      # Layout
      circle_layout = "monocle,tile";
      tag_rule = builtins.genList (i: "id:${toString (i + 1)},layout_name:monocle") 9;

      # Theming
      border_px = 0;
      gap_outer = {
        horizontal = 0;
        vertical = 0;
      };

      # Monocle
      tab_bar_height = 0;

      # Jump
      jump_label_decorate = {
        fg_color = "0x${colors.foreground}ff";
        bg_color = "0x${colors.background}ff";
        focus = {
          fg_color = "0x${colors.foreground}ff";
          bg_color = "0x${colors.background}ff";
        };
        border = {
          color = "0xec4067ff";
          width = 4;
        };
        corner_radius = 5;
        padding = {
          x = 10;
          y = 10;
        };
        font_desc = "${fonts.name} 24";
      };

      # Bindings
      bind = [
        # reload
        "super+shift, r, reload_config"
        # lock
        "super, l, spawn, noctalia msg session lock"
        # kill client
        "super, c, killclient"
        # open jump
        "alt, tab, togglejump"
        # workspace navigation
        "super, left, viewtoleft"
        "super, right, viewtoright"
        # switch layout
        "super+shift, tab, switch_layout"
        # monocle change focused window
        "super, tab, focusstack, next"
        # Move window to other tag/workspace
        "super+ctrl, left, tagtoleft"
        "super+ctrl, right, tagtoright"
        # Move window to other monitors
        "super+shift, left, tagmon, left"
        "super+shift, right, tagmon, right"
        # 
      ]
      # Apps
      ++ [
        "super, t, spawn, footclient"
        "super, r, spawn, noctalia msg panel-toggle launcher"
        "super, z, spawn, zen"
        "super, e, spawn, footclient -e 'yazi'"
      ]
      # Volume, Player & Brightness control
      ++ [
        "none, XF86AudioRaiseVolume, spawn, noctalia msg volume-up"
        "none, XF86AudioLowerVolume, spawn, noctalia msg volume-down"
        "none, XF86AudioMute, spawn, noctalia msg volume-mute"
        "none, XF86MonBrightnessUp, spawn, noctalia msg brightness-up"
        "none, XF86MonBrightnessDown, spawn, noctalia msg brightness-down"
        "none, XF86AudioPlay, spawn, playerctl play-pause"
      ]
      ++ builtins.genList (i: "super, ${toString (i + 1)}, view, ${toString (i + 1)}") 9;
      gesturebind = [
        "none, left, 3, viewtoright"
        "none, right, 3, viewtoleft"
      ];

      monitor_rule = [
        #queen
        "model:PL2770H, serial:1244742501074, width:1920, height:1080, refresh:180, x:1920, y:0"
        "model:PL2770H, serial:1244742500978, width:1920, height:1080, refresh:180, x:3840, y:0"
        "model:PL2730H, serial:1153690703375, width:1920, height:1080, refresh:75, x:0, y:0"

        #aigis
        "model:0x0928, width:1920, height:1080, refresh:60, x:0, y:0"

        # euphausia
        "model:0x0BC9, width:2560, height:1600, refresh:165, x:0, y:0, scale:1.5"
      ];
    };
  };

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
    mpv
    ppsspp
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
