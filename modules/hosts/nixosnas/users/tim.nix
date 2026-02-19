{
  inputs,
  self,
  ...
}:
{
  flake.modules.nixos.NixOSNAS =
    { config, ... }:
    {
      imports = with inputs.self.modules.nixos; [ 
      ];

      users.users.tim = {
        isNormalUser = true;
        description = "Tim";
        initialPassword = "changeme";
        extraGroups = [
          "wheel"
        ];

        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID3jBccnyu9qNn8B9iDTUSCIedKUA5J/HJDOhoUMMRgM"
        ];
      };

      home-manager.users.tim = {
        imports = [
          inputs.self.modules.homeManager.system-cli
        ];
      };
    };
}