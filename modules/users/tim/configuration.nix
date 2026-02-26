{
  inputs,
  self,
  ...
}:

let
  username = "tim";
in
{
  flake.modules.nixos."${username}" =
    {
      lib,
      config,
      pkgs,
      ...
    }:
    {

      imports = with inputs.self.modules.nixos; [
        steam
        obs
      ];

      home-manager.users."${username}" = {
        imports = [
          inputs.self.modules.homeManager."${username}"
        ];
      };

      users.users."${username}" = {
        isNormalUser = true;
        description = "Tim";
        initialPassword = "changeme";
        extraGroups = [
          "wheel" "vtune"
        ];
      };
    };
}