{
  flake.modules.nixos.TimsLaptop = {
    nixpkgs.hostPlatform = "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = true;
  };
}