{
  inputs,
  ...
}:
{
  flake-file.inputs = {
    factory_game = {
      # NOTE(Tim): Github scheme does not allow lfs
      url = "git+https://github.com/BloodStainedCrow/FactoryGame.git?ref=dev&lfs=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  imports = [ ];
}