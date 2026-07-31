{
  inputs,
  ...
}:
{
  flake.modules.nixos.kdePlasma = 
  { pkgs, ... }:
  {
    # Enable the KDE Plasma Desktop Environment.
    services = {
      displayManager.plasma-login-manager.enable = true;
      desktopManager.plasma6.enable = true;
    };
  };
}