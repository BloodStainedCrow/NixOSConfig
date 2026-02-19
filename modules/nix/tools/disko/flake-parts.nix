{
  inputs,
  ...
}:
{
  # Manage a file systems/partitions using nix
  flake-file.inputs = {
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  imports = [ 
    # inputs.disko.flakeModules.disko
  ];
}