{
  flake.modules.nixos.zfs-autoscrub = {
    services.zfs.autoScrub.enable = true;
    services.zfs.autoScrub.interval = "weekly";
  };
}