let
  hostname = "Tims-Predator-Laptop";
in
{
  flake.modules.nixos."${hostname}" = {
    nixpkgs.hostPlatform = "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = true;

    boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
    boot.kernelModules = [ "kvm-intel" ];

    hardware.enableRedistributableFirmware = true;
    hardware.usb-modeswitch.enable = true;
  };
}