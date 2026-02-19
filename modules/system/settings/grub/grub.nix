{
  flake.modules.nixos.grub = {
    boot.loader = {
      grub = {
        enable = true;
        efiSupport = true;

        # FIXME: nodev is for zfs impermanence
        device = "nodev";
      };
    };
  };
}