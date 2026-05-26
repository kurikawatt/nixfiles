{ pkgs
, inputs
, config
, lib
, ...
}:
lib.mkIf (config.me.desktop == "mango") {
  services.displayManager.ly.enable = true;

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
      colors = {
        # Rose Piné
        background = "191724";
        foreground = "e0def4";

        regular0 = "26233a";
        regular1 = "eb6f92";
        regular2 = "9ccfd8";
        regular3 = "f6c177";
        regular4 = "31748f";
        regular5 = "c4a7e7";
        regular6 = "ebbcba";
        regular7 = "e0def4";

        bright0 = "47435d";
        bright1 = "ff98ba";
        bright2 = "c5f9ff";
        bright3 = "ffeb9e";
        bright4 = "5b9ab7";
        bright5 = "eed0ff";
        bright6 = "ffe5e3";
        bright7 = "fefcff";

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
