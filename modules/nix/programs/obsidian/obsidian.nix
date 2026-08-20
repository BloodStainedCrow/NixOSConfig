{inputs, ...}:
{
  flake.modules.homeManager.obsidian = {pkgs, config, ...}:
  {
    imports = with inputs.self.modules.homeManager; [ 
    ];

    home.packages = [
      pkgs.obsidian
    ];
  };
}