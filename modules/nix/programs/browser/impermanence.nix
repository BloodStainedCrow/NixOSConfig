{
  inputs,
  ...
}:
{
  flake.modules.homeManager.browser =
    {
      config,
      lib,
      ...
    }:
    {
      home.persistence = inputs.self.lib.addPersistedFolders config [
        ".mozilla/firefox"
      ];
    };
}