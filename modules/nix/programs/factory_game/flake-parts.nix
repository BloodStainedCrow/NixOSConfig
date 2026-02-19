{
  inputs,
  ...
}:
{
  flake-file.inputs = {
    # factory_game_main = {
    #   url = "github:BloodStainedCrow/FactoryGame";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    factory_game_dev = {
      url = "github:BloodStainedCrow/FactoryGame/dev";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  imports = [ ];
}