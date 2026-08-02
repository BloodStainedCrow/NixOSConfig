let
  hostname = "Annes-Laptop";
in
{
  flake.modules.nixos."${hostname}" = { config, ... }: 
  {
    boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" ];

    # WIFI driver 
    boot.extraModulePackages = with config.boot.kernelPackages; [ broadcom_sta ];
    # FIXME: This is a borked driver which no longers gets updated/maintained. I should switch the wifi module
    nixpkgs.config.permittedInsecurePackages = [
      "broadcom-sta-6.30.223.271-59-6.18.38"
    ];

    hardware.cpu.intel.updateMicrocode = true;
  };
}