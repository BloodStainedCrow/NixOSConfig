{
  lib, 
  ...
}:
{
  flake.modules.nixos.grub = {

    imports = [
      ({config, ...}: {
        boot.loader = {
          timeout = lib.mkIf config.grub.hide 0;
          grub = {
            enable = true;
            efiSupport = true;
            efiInstallAsRemovable = true;

            # According to the disko quickstart, `device` is not required here:
            # https://github.com/nix-community/disko/blob/master/docs/quickstart.md
            # But without it nixos fails to build???

            # device = config.grub.device;
            device = "nodev";
          };
        };
      })
    ];

    options = {
      grub.device = lib.mkOption {
        type = lib.types.str;
      };

      grub.hide = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
    };
  };
}