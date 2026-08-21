{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/sda";
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
        device = "/dev/sdb";
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
        device = "/dev/sdc";
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
        device = "/dev/sdd";
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
