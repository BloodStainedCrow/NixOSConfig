{
  inputs,
  ...
}:
{
  flake.modules.homeManager.discord =
    {
      config,
      lib,
      ...
    }:
    {
      home.persistence = inputs.self.lib.addPersistedFolders config [
        ".config/discord"
        ".config/vesktop"
        ".config/Electron"
      ];
    };
}