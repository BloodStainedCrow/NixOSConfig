{
  flake.modules.nixos.cli-tools =
    {
      pkgs,
      lib,
      ...
    }:
    {
      environment.systemPackages =
        with pkgs;
        [ ];
    };
}