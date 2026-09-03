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

  inherit (osConfig.me) fonts colors;
in
{

  imports = (import-tree ./modules);

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
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "battery"
          "network"
        ] 
        #++ (if osConfig.me.services.fuuka.enable then [ "network#fuuka" ] else [])
        ++ [
          "wireplumber"
          "tray"
        ];

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
          font-family: ${fonts.name};
          font-size: 16px;
        }

        window#waybar {
          background-color: #${colors.background};
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
          color: #${colors.foreground};
        }

        tooltip {
          background-color: #${colors.background};
        }

        tooltip label {
          padding: 10px;
          background-color: #${colors.background};
        }
      '';
  };
}
