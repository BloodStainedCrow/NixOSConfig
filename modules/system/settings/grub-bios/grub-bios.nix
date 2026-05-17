{
  flake.modules.nixos.grub-bios = {
    boot.loader = {
      grub = {
        enable = true;

        # FIXME: Figure out a way to not need this defined here
        device = "/dev/sda";
      };
    };
  };
}