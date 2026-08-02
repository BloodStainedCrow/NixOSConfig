{
  inputs,
  ...
}:
{
  # Simple desktop system for use by "non-power-users"

  flake.modules.nixos.system-simple-desktop = {
    imports = with inputs.self.modules.nixos; [
      system-cli
      printing
      kdePlasma
    ];
  };

  flake.modules.homeManager.system-simple-desktop = {
    imports = with inputs.self.modules.homeManager; [
      simple-browser
      office
      kmail
    ];
  };
}