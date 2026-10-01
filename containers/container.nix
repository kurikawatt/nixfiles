{
  pkgs,
  ...
}:
{
  nixpkgs.system = "x86_64-linux";
  system.stateVersion = "26.05";
}