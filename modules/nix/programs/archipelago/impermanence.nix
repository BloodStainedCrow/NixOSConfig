{
  inputs,
  ...
}:
{
  flake.modules.homeManager.archipelago =
    {
      config,
      lib,
      ...
    }:
    {
      # FIXME: If this folder does not exist and gets created it is owned by root:root for some reason
      # FIXME: The Players and Templates are read only for some reason
      home.persistence = inputs.self.lib.addPersistedFolders config [
        ".local/share/Archipelago"
      ];
    };
}