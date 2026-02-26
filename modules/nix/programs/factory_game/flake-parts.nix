{
  inputs,
  ...
}:
{
  flake-file.inputs = {
    factory_game_main = {
      # NOTE(Tim): Github scheme does not allow lfs
      url = "git+https://github.com/BloodStainedCrow/FactoryGame.git?ref=master&lfs=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    factory_game_dev = {
      # NOTE(Tim): Github scheme does not allow lfs
      url = "git+https://github.com/BloodStainedCrow/FactoryGame.git?ref=dev&lfs=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  imports = [ ];
}