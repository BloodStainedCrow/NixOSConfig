# DO-NOT-EDIT. This file was auto-generated using github:vic/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);

  inputs = {
    disko = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/disko";
    };
    factory_game = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:BloodStainedCrow/FactoryGame/dev";
    };
    factory_game_dev = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:BloodStainedCrow/FactoryGame/dev";
    };
    firefox-addons = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:petrkozorezov/firefox-addons-nix";
    };
    flake-file.url = "github:vic/flake-file";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager/release-25.11";
    };
    impermanence.url = "github:Musholic/impermanence/home_suffix_fix";
    import-tree.url = "github:vic/import-tree";
    intel-oneapi-vtune = {
      flake = false;
      url = "path:./packages-custom/intel-oneapi-vtune/package.nix";
    };
    intel-vtune-sepdk = {
      flake = false;
      url = "path:./kernelModules/intel-vtune-sepdk";
    };
    nix-index = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/nix-index";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    old-nixpkgs.url = "github:nixos/nixpkgs/23.05";
    packages = {
      flake = false;
      url = "path:./packages";
    };
    pkgs-by-name-for-flake-parts.url = "github:drupol/pkgs-by-name-for-flake-parts";
  };

}
