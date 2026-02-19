{
  inputs,
  ...
}:
{
  flake.modules.nixos.nix-index = {pkgs, ...}:
  {
    environment.systemPackages = [
      inputs.nix-index.packages.${pkgs.system}.default
    ];
  };
}