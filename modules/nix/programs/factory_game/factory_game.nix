{
  inputs, ...
}:
{
  flake.modules.homeManager.factory_game =
    {
      pkgs,
      lib,
      ...
    }:
    {
      home.packages = with pkgs; [
      ];
      home.shellAliases.factory-dev = lib.getExe' inputs.factory_game_dev.packages.${pkgs.system}.default "factory";
      # home.shellAliases.factory-main = lib.getExe' inputs.factory_game_main.packages.${pkgs.system}.default "factory";
    };
}