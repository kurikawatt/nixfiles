{ config
, osConfig
, lib
, pkgs
, inputs
, ...
}:
let
  inherit (osConfig.me) fonts colors;
in
{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        layout = "overlay";
        font = "${fonts.name}:size=14";
        terminal = "${pkgs.foot}/bin/foot";
        enable-mouse = false;
        icons-enabled = false;
      };
      border = {
        width = 2;
        radius = 0;
      };
      colors = {
        background = "#${colors.background}ff";
        text = "#${colors.foreground}ff";
        prompt = "#${colors.foreground}ff";
        placeholder = "#6e6a86ff";
        input = "#${colors.foreground}ff;";
        match = "#${builtins.elemAt colors.regulars 4}ff";
        selection = "#403d52ff";
        selection-text = "#${colors.foreground}ff";
        selection-match = "#ebbcbaff";
        counter = "#f6c177ff";
        border = "#ec4067ff";
      };
    };
  };
}