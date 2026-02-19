{
  inputs,
  ...
}:
{
  flake.modules.homeManager.steam =
    {
      config,
      lib,
      ...
    }:
    {
      home.persistence = inputs.self.lib.addPersistedFolders config [
        ".local/share/steam"
      ];
    };
}