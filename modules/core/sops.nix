{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config) me;
in
{
  sops.gnupg.sshKeyPaths = [ ];

  sops.age = { }
  // lib.optionalAttrs (me.host.security.secureboot && me.host.security.tpm2) {
    keyFile = "/etc/tpm_age";
    plugins = with pkgs; [ age-plugin-tpm ];
  }
  // lib.optionalAttrs (!me.host.security.tpm2) {
    sshKeyPaths = [ "/home/kurik/.ssh/id_ed25519" ];
  };
}