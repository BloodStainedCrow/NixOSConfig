{ ... }:
{
  flake.modules.nixos.wifi = {
    networking.wireless.enable = true;
    networking.networkmanager.enable = false;
  };
}