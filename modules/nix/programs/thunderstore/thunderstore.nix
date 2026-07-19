{
  flake.modules.homeManager.thunderstore =
    {
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [
        r2modman
      ];
    };

    # TODO: Impermanence
}