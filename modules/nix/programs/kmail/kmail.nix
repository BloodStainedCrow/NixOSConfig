{
  inputs,
  ...
}:
{
  flake.modules.homeManager.kmail =
    {
      pkgs,
      config,
      ...
    }:
    {
      home.packages = [ 
        pkgs.kdePackages.kmail
        pkgs.kdePackages.kmail-account-wizard  
      ];
    };
}