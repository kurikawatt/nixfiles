{ config
, lib
, pkgs
, inputs
, ...
}:
let
  homeDir = "/home/kurik";
in
{
  home.stateVersion = "25.11";

  home.file = {
    ".bashrc".source = ../dotfiles/.bashrc;
    "scripts".source = ../scripts;
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
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

  home.packages = with pkgs; [
    tree
    fastfetch
    vesktop
    obsidian
    thunderbird
    sops
    udiskie
    jellyfin-desktop
    deluge
    gimp
    gh

    nixd
    nixpkgs-fmt

    deezer-enhanced

    archipelago
    poptracker

    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
    ];
    extraLuaConfig = ''
          -- Basic config for LSP --
          local lspconfig = require('lspconfig')
          lspconfig.nixd.setup({
            settings = {
              nixd = {
                formatting = {
                  command = { "nixpkgs-fmt" },
      	  },
      	},
            },
          })
          -- Autoformat on save
          vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.nix",
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
          })
    '';
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
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
        cudaSupport = true;
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
        modules-left = [
          "custom/hostname"
          "group/cpu-temp"
          "memory"
          "dwl/window"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "tray"
          "network"
          "network#fuuka"
          "wireplumber"
          "battery"
        ];
        "custom/hostname" = {
          format = "{}";
          exec = "cat /etc/hostname";
        };
        network = {
          format-wifi = "{essid}";
          format-ethernet = "Wired";
          format-disconnected = "No Network";
          format-disabled = "Airplane Mode";
          tooltip-format = "Strength : {signalStrength}%\n{ipaddr}/{cidr}\n↑ {bandwidthUpOctets} | ↓ {bandwidthDownOctets}";
        };
        "network#fuuka" = {
          interface = "fuuka0";
          format-connected = "Fuuka";
          format-disabled = "";
          tooltip-format = "{ipaddr}/{cidr}\n↑ {bandwidthUpOctets} | ↓ {bandwidthDownOctets}";
        };
        "wireplumber" = {
          format = " vol : {volume}%";
          format-muted = "vol : muted";
          nospacing = 1;
          scroll-step = 1;
        };
        battery = {
          format = "{capacity}%";
          interval = 10;
          states = {
            warning = 30;
            critical = 10;
          };
          tooltip = false;
        };
        "group/cpu-temp" = {
          orientation = "horizontal";
          modules = [ "cpu" "temperature" ];
        };
        cpu = {
          interval = 10;
          format = "cpu : {usage}%";
        };
        temperature = {
          interval = 10;
          critial-threshold = 80;
          format = " ({temperatureC}°C)";
          format-critical = " ({temperatureC}°C))";
        };
        memory = {
          interval = 10;
          format = "mem : {used:0.1f}/{total:0.1f}Go";
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
                  background-color: #191724;
                }

                #battery,
                #clock,
                #wireplumber,
                #network,
                #tray,
                #custom-hostname,
        	#group-cpu,
        	#memory {
                  margin: 5px;
                  padding: 6px 12px;
                }

                #custom-hostname {
                  color: #ECE14B;
                }

                #battery,
                #clock,
                #wireplumber,
                #network,
                #workspaces,
                #tray {
                  color: #e0def4;
                }

                #battery {
                  color: #061826;
                  background-color: #3e8fb0;
                }

                #battery.warning {
                  background-color: #f6c177;
                }

                #battery.critical,
                #battery.urgent {
                  background-color: #eb6f92;
                }

                #battery.charging {
                  background-color: #01CB5F;
                }

                tooltip {
                  background-color: #191724;
                }

                tooltip label {
                  padding: 10px;
                  background-color: #191724;
                }
      '';
  };

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        layout = "overlay";
        font = "Cascadia Code:size=12";
        enable-mouse = false;
        icons-enabled = false;
      };
      border = {
        width = 3;
        radius = 0;
      };
      colors = {
        background = "#191724ff";
        text = "#e0def4ff";
        prompt = "#e0def4ff";
        placeholder = "#6e6a86ff";
        input = "#e0def4ff;";
        match = "#ebbcbaff";
        selection = "#403d52ff";
        selection-text = "#e0def4ff";
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
      width = "450";
      height = "128";
      padding = "24";
      font = "Cascadia Code 12";
      text-color = "#e0def4";
      background-color = "#191724";
      border-color = "#ec4067";
      default-timeout = 3000;
      "urgency=critical" = {
        default-timeout = 0;
      };
    };
  };
}
