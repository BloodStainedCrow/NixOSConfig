{
  inputs,
  self,
  ...
}:

let
  username = "tim";
in
{
  flake.modules.nixos.tim-work =
    {
      lib,
      config,
      pkgs,
      ...
    }:
    {

      imports = with inputs.self.modules.nixos; [
      ];

      home-manager.users."${username}" = with inputs.self.modules.homeManager; {
        imports = [
          inputs.self.modules.homeManager.tim-work
        ];
      };

      users.users."${username}" = {
        isNormalUser = true;
        description = "Tim Aschhoff";
        initialPassword = "changeme";
        extraGroups = [
          "wheel" "networkmanager"
        ];
      };
    };
}