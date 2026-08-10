{
  inputs,
  ...
}:
{
  flake.modules.homeManager.mattermost =
    {
      pkgs,
      config,
      ...
    }:
    {
      home.packages = [ 
        pkgs.mattermost
      ];
    };
}