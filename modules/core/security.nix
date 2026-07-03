{
  pkgs,
  ...
}:
{
  security.rtkit.enable = true;

  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
  };

  environment.systemPackages = with pkgs; [ clamav ];
}