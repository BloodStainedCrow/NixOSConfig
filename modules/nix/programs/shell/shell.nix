{
  flake.modules.homeManager.shell =
    {
      config,
      ...
    }:
    {
      programs.nushell = {
        enable = true;
      };

      programs.bash = {
        enable = true;
        enableCompletion = true;
      };
    };

}