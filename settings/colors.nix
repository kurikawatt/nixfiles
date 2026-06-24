{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkOption types;
in
{

  /* Default values are inspired by Tokyo Night colors palette */

  options.me.colors = {

    foreground = mkOption {
      type = str;
      default = "c0caf5";
      description = "Foreground color";
    };

    background = mkOption {
      type = str;
      default = "1a1b26";
      description = "Background color";
    };

    regulars = mkOption {
      type = listOf str;
      default = [
        "15161E" # black
        "f7768e" # red
        "9ece6a" # green
        "e0af68" # yellow
        "7aa2f7" # blue
        "bb9af7" # magenta
        "7dcfff" # cyan
        "a9b1d6" # white
      ];
      description = "Regular colors"
    };

    brights = mkOption {
      type = listOf str;
      default = [
        "414868" # black
        "f7768e" # red
        "9ece6a" # green
        "e0af68" # yellow
        "7aa2f7" # blue
        "bb9af7" # magenta
        "7dcfff" # cyan
        "c0caf5" # white
      ];
      description = "Bright colors"
    };

    dimmed = mkOption {
      type = listOf str;
      default = [
        "ff9e64"
        "db4b4b"
      ];
      description = "Dimmed colors"
    }

  };

}