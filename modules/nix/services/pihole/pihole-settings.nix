
{ inputs, lib, ...}: {
  flake.modules.nixos.pihole-settings = {
    options.pihole.storage-path = lib.mkOption {
      type = lib.types.uniq lib.types.str;
    };

    options.pihole.public-ip = lib.mkOption {
      type = lib.types.uniq lib.types.str;
    };
  };
}