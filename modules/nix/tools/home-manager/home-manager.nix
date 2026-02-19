{
  inputs,
  config,
  ...
}:
let
  home-manager-config =
    { lib, ... }:
    {
      home-manager = {
        verbose = true;
        # TODO: See https://github.com/nix-community/home-manager/blob/7560dc942a6fbd37ebd1310b3dbda513de2d4b82/nixos/common.nix#L51-L54
        # for now I will have these commented out
        # useUserPackages = true;
        # useGlobalPkgs = true;
        backupFileExtension = "backup";
        # backupCommand = "rm";
        overwriteBackup = true;
      };
    };
in
{
  flake.modules.nixos.home-manager = {
    imports = [
      inputs.home-manager.nixosModules.home-manager
      home-manager-config
    ];
  };

}