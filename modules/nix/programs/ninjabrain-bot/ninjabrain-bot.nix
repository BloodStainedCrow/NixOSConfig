{inputs, ...}:
{
  flake.modules.homeManager.ninjabrain-bot = {pkgs, config, ...}:
  {
    imports = [ ];

    home.packages = [
      pkgs.local.ninjabrain-bot
      # FIXME
      pkgs.openjdk
      pkgs.unstable.waywall
    ];
  };
}