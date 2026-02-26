{
  inputs,
  ...
}:
{
  flake.modules.homeManager.minecraft =
    {
      config,
      lib,
      ...
    }:
    {
      home.persistence = inputs.self.lib.addPersistedFolders config [
        ".local/share/prismlauncher"
      ];
    };
}