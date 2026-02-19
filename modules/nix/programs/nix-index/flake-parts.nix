{
  inputs,
  ...
}:
{
  flake-file.inputs = {
    nix-index = {
      url = "github:nix-community/nix-index";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}