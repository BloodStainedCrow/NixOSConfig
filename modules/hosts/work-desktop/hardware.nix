{
  flake.modules.nixos.Tims-Work-Desktop = {
    nixpkgs.hostPlatform = "x86_64-linux";
    hardware.cpu.amd.updateMicrocode = true;

    boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" ];
    boot.kernelModules = [ "kvm-amd" ];
  };
}