{
  inputs,
  ...
}:
{
  flake.modules.homeManager.ninjabrain-bot =
    {
      config,
      lib,
      ...
    }:
    {
      home.persistence = inputs.self.lib.addPersistedFolders config [
        # ".config/waywall"
      ];
    };
}