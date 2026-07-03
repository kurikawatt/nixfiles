{
  pkgs,
  config,
  ...
}:
let
  inherit (config) me;
in
{
  boot.initrd.availableKernelModules =
    if me.host.security.tpm2 then [ "tpm_tis" "tpm_crb" "tpm_tis_core" ]
    else [];

  security.rtkit.enable = true;

  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
  };

  # Fingerprint auth
  services.fprintd.enable = me.host.security.fingerprint;

  security.pam.services = {
    ly.fprintAuth = me.host.security.fingerprint;
    swaylock.fprintAuth = me.host.security.fingerprint;
  };

  security.tpm2 = {
    enable = me.host.security.tpm2;
    pkcs11.enable = me.host.security.tpm2;
    tctiEnvironment.enable = me.host.security.tpm2;
  };

  environment.systemPackages = with pkgs; [
    clamav
  ]
  ++ (if me.host.security.secureboot then [ sbctl ] else [])
  ++ (if me.host.security.tpm2 then [ tpm2-tools ] else []); 
}