{ config
, osConfig
, lib
, pkgs
, inputs
, ...
}:
let
  inherit (osConfig.me.host) screen;
in
{
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      font-size = 24;
      indicator-idle-visible = false;
      show-failed-attempts = false;

      indicator-x-position = 0.5 * (screen.width / screen.scale);
      indicator-y-position = 0.75 * (screen.height / screen.scale);

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
}