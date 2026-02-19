{
  inputs,
  ...
}:
{
  flake.modules.homeManager.obs =
    {
      config,
      lib,
      ...
    }:
    {
      home.persistence = inputs.self.lib.addPersistedFolders config [
        ".config/obs-studio"
      ];
    };
}