{
  inputs, ...
}:
{
  flake.modules.nixos.factory_game_dedicated_server  =
    {
      pkgs,
      lib,
      ...
    }:
    {
      systemd.user.services.factory_game_dedicated_server = {
        path = [ inputs.factory_game.packages.${pkgs.system}.dedicated_server ];
        script = "factory";
        environment = {
          
        };
        serviceConfig = {
          User = "tim";
        };
      };

      networking.firewall = {
        allowedTCPPorts = [ 42069 ];
      };
    };
}