{
  ...
}:
{
  import = [
    ./plymouth.nix
  ];
  
  boot.loader.limine = {
    enable = true;
    enableEditor = false;
    maxGenerations = null;
  };

  boot.loader.limine.secureBoot.enable = true;

  boot.loader.limine.style = {
    backdrop = "000000";
    wallpapers = [];
    interface = {
      branding = "";
    };
    graphicalTerminal = {
      background = "FF000000";
      foreground = "FFFFFF";
    };
  };

  boot.loader.efi.canTouchEfiVariables = true;
}
