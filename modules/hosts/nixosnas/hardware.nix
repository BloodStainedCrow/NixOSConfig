{
  flake.modules.nixos.NixOSNAS = {
    nixpkgs.hostPlatform = "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = true;

    # TODO: Move this out of here
    fileSystems."/" =
      { device = "/dev/disk/by-uuid/bc551a0f-c493-4f65-9b37-e4be42cee3b9";
        fsType = "ext4";
      };

    fileSystems."/boot" =
      { device = "/dev/disk/by-uuid/BE27-78EA";
        fsType = "vfat";
      };

    swapDevices =
      [ { device = "/dev/disk/by-uuid/0d0029cb-248f-4a3f-a756-c43f4b95cfde"; }
      ];
  };
}