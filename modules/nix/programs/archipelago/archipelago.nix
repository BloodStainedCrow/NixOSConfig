{
  flake.modules.homeManager.archipelago =
  {
    pkgs,
    ...
  }:
  {
    home.packages = [
      pkgs.archipelago
    ];
  };
}