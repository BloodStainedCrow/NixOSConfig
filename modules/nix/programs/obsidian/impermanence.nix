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
      # FIXME: THIS BREAKS WITHOUT IMPERMANENCE
      # home.persistence = inputs.self.lib.addPersistedFolders config [
      #   "Documents/obsidian_notes"
      # ];
    };
}