{
  flake.modules.homeManager.spotify =
    {
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [
        spotify
      ];
      programs.spotify-player = {
        enable = true;
      };
    };
}