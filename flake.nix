# DO-NOT-EDIT. This file was auto-generated using github:vic/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{
  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);

  inputs = {
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    factory_game = {
      url = "git+https://github.com/BloodStainedCrow/FactoryGame.git?ref=dev&lfs=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    factory_game_dev = {
      url = "git+https://github.com/BloodStainedCrow/FactoryGame.git?ref=dev&lfs=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    factory_game_main = {
      url = "git+https://github.com/BloodStainedCrow/FactoryGame.git?ref=master&lfs=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "github:petrkozorezov/firefox-addons-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-file.url = "github:vic/flake-file";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:Musholic/impermanence/home_suffix_fix";
    import-tree.url = "github:vic/import-tree";
    intel-oneapi-vtune = {
      url = "path:./packages-custom/intel-oneapi-vtune/package.nix";
      flake = false;
    };
    intel-vtune-sepdk = {
      url = "path:./kernelModules/intel-vtune-sepdk";
      flake = false;
    };
    nix-index = {
      url = "github:nix-community/nix-index";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    old-nixpkgs.url = "github:nixos/nixpkgs/23.05";
    packages = {
      url = "path:./packages";
      flake = false;
    };
    pkgs-by-name-for-flake-parts.url = "github:drupol/pkgs-by-name-for-flake-parts";
  };
}
