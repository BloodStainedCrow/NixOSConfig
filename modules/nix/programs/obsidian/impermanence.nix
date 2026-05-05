{
  inputs,
  ...
}:
{
  flake.modules.homeManager.obsidian =
    {
      config,
      lib,
      ...
    }:
    {
      home.persistence = inputs.self.lib.addPersistedFolders config [
        "Documents/obsidian_notes"
      ];
    };
}