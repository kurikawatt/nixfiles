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
    "kitty".source = ../dotfiles/kitty;
    "palettes".source = ../dotfiles/palettes;
    "mako".source = ../dotfiles/mako;
    "fuzzel".source = ../dotfiles/fuzzel;
    "swayosd".source = ../dotfiles/swayosd;
    "waybar".source = ../dotfiles/waybar;
    "yazi".source = ../dotfiles/yazi;
    "hypr".source = ../dotfiles/hypr;
    "noctalia".source = ../dotfiles/noctalia;
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
