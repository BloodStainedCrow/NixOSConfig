{
    device ? throw "Set this to your disk device, e.g. /dev/sda",
    swapsize ? throw "Set this to your preferred amount of swap",
}:
{
  disko.devices = {
    disk = {
      mainSSD = {
        type = "disk";
        device = "/dev/sdx";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              name = "ESP";
              size = "500M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                # mountOptions = [ "umask=0077" ];
              };
            };
            swap = {
              size = swapsize;
              content = {
                type = "swap";
                resumeDevice = true;
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zroot";
              };
            };
          };
        };
      };
    };
    zpool = {
      zroot = {
        type = "zpool";
        # This means NO redundancy! 
        mode = "single";
        # Workaround: cannot import 'zroot': I/O error in disko tests
        options.cachefile = "none";

        # See https://jrs-s.net/2018/08/17/zfs-tuning-cheat-sheet/
        rootFsOptions = {
          compression = "lz4";
          ashift = 12;
          xattr = "sa";
          atime = "off";
          "com.sun:auto-snapshot" = "false";
        };
        # If the blank snapshot does not exist, create it recursively for all datasets
        postCreateHook = "zfs list -t snapshot -H -o name | grep -E '^zroot@blank$' || zfs snapshot zroot@blank -r";

        datasets = {
          root = {
            # This gets wiped every reboot!
            type = "zfs_fs";
            mountpoint = "/";
          };
          nix = {
            type = "zfs_fs";
            mountpoint = "/nix";
          };
          system = {
            type = "zfs_fs";
            mountpoint = "/persist/system";
          };
          # TODO: Dataset per user
          user = {
            type = "zfs_fs";
            mountpoint = "/persist/user";

            datasets = {
              tim = {
                type = "zfs_fs";
              };
            };
          };
        };
      };
    };
  };
}
