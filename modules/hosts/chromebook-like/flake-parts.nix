{
  self,
  inputs,
  ...
}:
{
  flake.nixosConfigurations = {}
    // inputs.self.lib.mkNixos "x86_64-linux" "SimpleNixosPC"
    // inputs.self.lib.mkNixos "x86_64-linux" "SimpleNixosPCInstaller"
  ;

  perSystem.packages = {
    SimpleNixosPCInstallerISO = self.nixosConfigurations.SimpleNixosPCInstaller.config.system.build.isoImage;
  };
}