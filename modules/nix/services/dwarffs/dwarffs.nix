{
  inputs, ...
}:
{
  flake.modules.nixos.dwarffs  =
    {
      pkgs,
      lib,
      ...
    }:
    {
      imports =
        [
          # FIXME: dwarffs seems to be broken currently.
          # Both an import (due to changed nix interface even tho nix is pinned????)
          # And a potential breakage due to different compiler?
          inputs.dwarffs.nixosModules.dwarffs
        ];
    };
}