{
  inputs,
  config,
  lib,
  options,
  ...
}:
let
  disko-config =
    { lib, options, pkgs, config, ... }:
    {
      # AFAIK this is what I should use but it fails for some reason?
      # boot.zfs.package = config.boot.kernelPackages.${pkgs.zfs.kernelModuleAttribute};
      boot.zfs.package = pkgs.zfs_2_4;


      disko.devices = {
        disk = {
          mainSSD = {
            type = "disk";
            device = options.disko.device;
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
                  size = options.disko.swapsize;
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
            # TODO: This might be broken
            # mode = "single";
            
            options = {
              # Workaround: cannot import 'zroot': I/O error in disko tests
              cachefile = "none";
              ashift = "12";
            };

            # See https://jrs-s.net/2018/08/17/zfs-tuning-cheat-sheet/
            rootFsOptions = {
              compression = "lz4";
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
              "user/tim" = {
                type = "zfs_fs";
                mountpoint = "/persist/user/tim";
              };
            };
          };
        };
      };
    };
in
{
  flake.modules.nixos.disko = {
    imports = [
      inputs.disko.nixosModules.default
      disko-config
      inputs.self.modules.nixos.zfs-autoscrub
    ];

    options = {
      disko.device = lib.mkOption {
        type = lib.types.attrsOf lib.types.externalPath;
      };
      disko.swapsize = lib.mkOption {
        type = lib.types.attrsOf lib.types.str;
      };
    };
  };


}