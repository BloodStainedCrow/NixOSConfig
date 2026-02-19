{
  inputs,
  ...
}:
{
  flake-file.inputs = {
    firefox-addons = {
      url = "github:petrkozorezov/firefox-addons-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  imports = [ ];
}