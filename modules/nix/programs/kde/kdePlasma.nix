{
  inputs,
  ...
}:
{
  flake.modules.nixos.kdePlasma = 
  { pkgs, ... }:
  {
    home-manager.sharedModules = [
      inputs.self.modules.homeManager.gnome
    ];

    # Enable the KDE Plasma Desktop Environment.
    services = {
      displayManager.plasma-login-manager.enable = true;
      desktopManager.plasma6.enable = true;
    };

  };
}