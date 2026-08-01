{
  flake.modules.nixos.auto-upgrade = {
    system.autoUpgrade = {
      enable = true;
      flake = "github:BloodStainedCrow/NixOSConfig";
      dates = "02:00";
      randomizedDelaySec = "45min";
      allowReboot = true;
    };

    nix.optimise.automatic = true;
  };
}