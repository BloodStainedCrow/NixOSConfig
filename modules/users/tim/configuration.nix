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

      home-manager.users."${username}" = with inputs.self.modules.homeManager; {
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