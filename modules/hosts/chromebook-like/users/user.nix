{
  inputs,
  self,
  ...
}:
{
  flake.modules.nixos.SimpleNixosPC =
    { config, ... }:
    {
      imports = with inputs.self.modules.nixos; [ 
      ];

      users.users.user = {
        isNormalUser = true;
        description = "Benutzer";
        # No user password needed
        hashedPassword = "";
        extraGroups = [];
      };

      home-manager.users.user = {
        imports = [
          inputs.self.modules.homeManager.system-simple-desktop
        ];
        home.stateVersion = "25.05";
      };
    };
}