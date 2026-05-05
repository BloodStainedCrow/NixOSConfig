{inputs, ...}:
{
  flake.modules.homeManager.obsidian = {pkgs, config, ...}:
  {
    imports = with inputs.self.modules.homeManager; [ 
      git
    ];

    home.packages = [
      pkgs.obsidian
    ];
  };
}