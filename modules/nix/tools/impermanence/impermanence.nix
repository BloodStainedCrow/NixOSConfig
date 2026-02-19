{
  inputs,
  ...
}:
{

  # convenience function to set persistence settings only,
  # if impermanence module was imported

  flake.lib = {
    mkIfPersistence =
      config: settings:
      if config ? home then
        (if config.home ? persistence then settings else { })
      else
        (if config.environment ? persistence then settings else { });

    addPersistedFolders =
      config: folderList:
      inputs.self.lib.mkIfPersistence config {
        "/persist/${(if config.home ? persistence then "user/${config.home.username}" else "system")}" = {
          directories = folderList;
        };
      };
  };

  flake.modules.nixos.impermanence = {
    imports = [
      inputs.impermanence.nixosModules.impermanence
    ];
  };
}