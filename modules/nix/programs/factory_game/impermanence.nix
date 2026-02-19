{
  inputs,
  ...
}:
{
  flake.modules.homeManager.factory_game =
    {
      config,
      lib,
      ...
    }:
    {
      home.persistence = inputs.self.lib.addPersistedFolders config [
        ".local/share/factory_game"
      ];
    };
}