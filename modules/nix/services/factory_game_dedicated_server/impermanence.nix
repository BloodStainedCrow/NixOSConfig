{
  inputs,
  ...
}:
{
  flake.modules.nixos.factory_game_dedicated_server  =
    {
      config,
      lib,
      ...
    }:
    {
        # TODO
      # environment.persistence = inputs.self.lib.addPersistedFolders config [
      # ];
    };
}