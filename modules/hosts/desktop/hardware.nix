{
  flake.modules.nixos.TimsKleinerPC = {
    nixpkgs.hostPlatform = "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = true;

    # Needed for wifi drivers
    hardware.enableRedistributableFirmware = true;
  };
}