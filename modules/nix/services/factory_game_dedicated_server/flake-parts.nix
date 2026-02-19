{
  inputs,
  ...
}:
{
  flake-file.inputs = {
    factory_game = {
      url = "github:BloodStainedCrow/FactoryGame/dev";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  imports = [ ];
}