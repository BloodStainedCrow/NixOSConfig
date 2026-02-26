{inputs, ...}:
{
  flake.modules.homeManager.minecraft = {pkgs, ...}: 
  {
    imports = [ ];

    home.packages = [
      pkgs.prismlauncher
    ];
  };
}