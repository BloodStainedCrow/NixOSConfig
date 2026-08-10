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
      boot.zfs.forceImportRoot = false;

      disko.devices = {
        disk = {
          mainSSD = {
            type = "disk";
            device = config.disko.device;
            content = {
              type = "gpt";
              partitions = {
                ESP = {
                  name = "ESP";
                  size = "2G";
                  type = "EF00";
                  content = {
                    type = "filesystem";
                    format = "vfat";
                    mountpoint = "/boot";
                    # mountOptions = [ "umask=0077" ];
                  };
                };
                biosBoot = lib.mkIf config.disko.useBios {
                  # Taken from https://github.com/nix-community/disko/blob/6e8dc7aa0e65fce67c76e18227a13a7d529f2cdf/example/gpt-bios-compat.nix
                  size = "1M";
                  type = "EF02"; # for grub MBR
                  attributes = [ 0 ]; # partition attribute
                };
                swap = lib.mkIf (config.disko.swapsize != "") {
                  size = config.disko.swapsize;
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

            datasets = {
              root = {
                # This gets wiped every reboot!
                type = "zfs_fs";
                mountpoint = "/";
                options = lib.mkIf config.disko.encryptRoot {
                  encryption = "aes-256-gcm";
                  keyformat = "passphrase";
                  keylocation = "prompt";
                };
              };
              nix = {
                type = "zfs_fs";
                mountpoint = "/nix";
              };
            };
          };
        };
      };
    };
in
{
  flake.modules.nixos.disko-no-impermanence = {
    imports = [
      inputs.disko.nixosModules.default
      disko-config
      inputs.self.modules.nixos.zfs-autoscrub
    ];

    options = {
      disko.device = lib.mkOption {
        type = lib.types.str;
      };
      disko.swapsize = lib.mkOption {
        type = lib.types.str;
        default = "";
      };
      disko.useBios = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
      disko.encryptRoot = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
    };
  };


}