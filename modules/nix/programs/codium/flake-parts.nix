{
  inputs,
  ...
}:
{
  flake-file.inputs = {
    nixpkgs-codium = {
      url = "github:nixos/nixpkgs?ref=91c9a64ce2a84e648d0cf9671274bb9c2fb9ba60";
    };
  };

  imports = [ ];
}