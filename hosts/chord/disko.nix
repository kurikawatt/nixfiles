{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/disk/by-id/wwn-0x500a07511a5cb41a";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00"; # EFI System
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
                extraArgs = [ "-n" "NIXBOOT" ];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
      chiyome = { # Wind's Persona
        type = "disk";
        device = "/dev/disk/by-id/wwn-0x5000c50051cf1f5b";
        content = {
          type = "gpt";
          partitions = {
            chiyome-root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/media/chiyome";
              };
            };
          };
        };
      };
      calliope = { # Chord's Persona
        type = "disk";
        device = "/dev/disk/by-id/wwn-0x5000cca35ed15d2a";
        content = {
          type = "gpt";
          partitions = {
            calliope-root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/media/calliope";
              };
            };
          };
        };
      };
      euterpe = { # Ange's Persona
        type = "disk";
        device = "/dev/disk/by-id/wwn-0x50014ee20a03b9fb";
        content = {
          type = "gpt";
          partitions = {
            euterpe-root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/media/euterpe";
              };
            };
          };
        };
      };
    };
  };
}
