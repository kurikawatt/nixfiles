{
  ...
}:
{
  boot.loader.limine = {
    enable = true;
    enableEditor = false;
    maxGenerations = 5;
  };

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
