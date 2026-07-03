{
  pkgs,
  inputs,
  config,
  lib,
  ...
}:
lib.mkIf (config.me.desktop == "mango") {
  services.displayManager.ly.enable = true;

  security.pam.services.swaylock = { };

  programs.mango.enable = true;

  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "Cascadia Mono:size=16";
        pad = "10x10 center";
        selection-target = "clipboard";
      };
      bell = {
        urgent = "no";
        notify = "no";
      };
      mouse = {
        hide-when-typing = "yes";
      };
      colors-dark = {

        background = config.me.colors.background;
        foreground = config.me.colors.foreground;

        regular0 = builtins.elemAt config.me.colors.regulars 0;
        regular1 = builtins.elemAt config.me.colors.regulars 1;
        regular2 = builtins.elemAt config.me.colors.regulars 2;
        regular3 = builtins.elemAt config.me.colors.regulars 3;
        regular4 = builtins.elemAt config.me.colors.regulars 4;
        regular5 = builtins.elemAt config.me.colors.regulars 5;
        regular6 = builtins.elemAt config.me.colors.regulars 6;
        regular7 = builtins.elemAt config.me.colors.regulars 7;

        bright0 = builtins.elemAt config.me.colors.brights 0;
        bright1 = builtins.elemAt config.me.colors.brights 1;
        bright2 = builtins.elemAt config.me.colors.brights 2;
        bright3 = builtins.elemAt config.me.colors.brights 3;
        bright4 = builtins.elemAt config.me.colors.brights 4;
        bright5 = builtins.elemAt config.me.colors.brights 5;
        bright6 = builtins.elemAt config.me.colors.brights 6;
        bright7 = builtins.elemAt config.me.colors.brights 7;

        dim0 = builtins.elemAt config.me.colors.dimmed 0;
        dim1 = builtins.elemAt config.me.colors.dimmed 1;

        flash = "f6c177";

        cursor = "191724 e0def4";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    # file explorer
    yazi
    # screenshots
    grim
    slurp
    # for gsettings
    glib
    gsettings-desktop-schemas

    brightnessctl
    playerctl

    wl-clipboard
    wl-clip-persist

    inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
  ];
}
