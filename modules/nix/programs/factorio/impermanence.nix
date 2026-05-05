{
  inputs,
  ...
}:
{
  flake.modules.homeManager.factorio =
    {
      config,
      lib,
      ...
    }:
    {
      home.persistence = inputs.self.lib.addPersistedFolders config [
        ".local/share/factorio"
      ];
    };
}