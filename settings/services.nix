{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkOption mkEnableOption types;
in
{
  options.me.services.global = {
    domain = mkOption {
      type = types.str;
      default = "kurikawa.fr";
      description = "Domain used for all services";
    };
  };

  options.me.services.tailscale = {
    enable = mkEnableOption "Enable Tailscale";
    interfaceName = mkOption {
      description = "Interface name for tailscale";
      type = types.str;
      default = "ts0";
    };
    tailnetDomain = mkOption {
      description = "Tailnet pretty URL ";
      type = types.str;
      default = "marten-matrix.ts.net";
    };
  };

  options.me.services.fuuka-dns = {
    enable = mkEnableOption "Enable DNS for fuuka";
  };

  options.me.services.jellyfin = {
    enable = mkEnableOption "Enable Jellyfin Server";
    port = mkOption {
      type = types.int;
      default = 8096;
      description = "Jellyfin port";
    };
  };

  options.me.services.prowlarr = {
    enable = mkEnableOption "Enable Prowlarr and usefull programs for gathering content";

    deluge-dataDir = mkOption {
      type = types.str;
      default = "/var/lib/deluge";
      description = "Deluge Data Directory";
    };
  };

  options.me.services.ollama = {
    enable = mkEnableOption "Enable Ollama + codeqwen 7b model";
  };

  options.me.services.restic = {
    enable = mkEnableOption "Enable Restic backup";
  };

  options.me.services.podman = {
    enable = mkEnableOption "Enable Podman + Docker compat.";
  };

  options.me.services.incus = {
    enable = mkEnableOption "Enable Incus";
  };
}
