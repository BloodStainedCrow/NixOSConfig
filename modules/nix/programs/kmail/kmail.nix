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
      # TODO: Kmail needs Kwallet
      home.packages = [ 
        pkgs.kdePackages.kmail
        pkgs.kdePackages.kmail-account-wizard  
      ];
    };
}