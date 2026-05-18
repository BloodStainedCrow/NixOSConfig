{
  lib, 
  ...
}:
{
  flake.modules.nixos.grub = {

    imports = [
      ({config, ...}: {
        boot.loader = {
          grub = {
            enable = true;
            efiSupport = true;
            efiInstallAsRemovable = true;

            # According to the disko quickstart, `device` is not required here:
            # https://github.com/nix-community/disko/blob/master/docs/quickstart.md
            # But without it nixos fails to build???

            device = config.grub.device;
          };
        };
      })
    ];

    options = {
      grub.device = lib.mkOption {
        type = lib.types.str;
      };
    };
  };
}