{
  inputs,
  ...
}:
{
  flake.nixosConfigurations = inputs.self.lib.mkNixos "x86_64-linux" "Tims-Work-Desktop";
  flake.homeConfigurations = inputs.self.lib.mkHomeManager inputs.nixpkgs.legacyPackages."x86_64-linux".stdenv "tim-work";
}