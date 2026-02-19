let
  genericPackages =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        lshw
        pciutils
        fd
        home-manager
        ripgrep
        file
      ];
    };
in
{
  flake.modules.nixos.cli-tools = {
    imports = [
      genericPackages
    ];
  };
}