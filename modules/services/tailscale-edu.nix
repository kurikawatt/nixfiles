{
  config,
  lib,
  pkgs,
  ...
}:
let
  tsInterfaceName = "tsedu0";
in
lib.mkIf (config.me.services.tailscale-edu.enable) {

  services.tailscale = {
    enable = true;
    interfaceName = tsInterfaceName;
  };

  networking.firewall.interfaces."tsedu0".allowedTCPPorts = [ 22 8484 ];
  networking.firewall.interfaces."tsedu0".allowedUDPPorts = [ 22 8484 ];

  users.users."beepboop" = {
    isNormalUser = true;
    home = "/home/beepboop";
    hashedPassword = "$y$j9T$TtdSG8ZfEoJrT0VBGBg0H1$MkBFuodCjO0BVGmitn8iySjnkSfP2JIlp2ejGsKeRM8";
    openssh.authorizedKeys.keys = [
      # ayko's keys
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIKtQ/n+Lg+BZdaGKAkJNykyf93bjvr++lCnEeHQuV6oTAAAABHNzaDo="
      "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIGTDz1++tiT0SytsEP3XzTshTI6Edd+o6nMTVl/iLxzSAAAABHNzaDo="
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIle7s0n8fPV/x6NzpMFbhuVsJgrsO94zW/Pd2QkF1CT"
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBDIZOAfbe03pFpRXeB5ll3wNv+rZNgZg4rtCoiNELf3JJ7m54ze7QUrsy8LgIVk08r+Q8tuwA16yA+oDpK9fuys="
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDmLPpxET8notgJ1mE3CzMv5yjZYfHhovcV+FzEGQek+"
    ];
  };

  security.sudo.execWheelOnly = true;
  security.pam.services.su.requireWheel = true;

}