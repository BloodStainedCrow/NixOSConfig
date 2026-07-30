{
  inputs,
  self,
  ...
}:
{
  flake.modules.nixos.SimpleNixosPC =
    { config, ... }:
    {
      imports =
        with inputs.self.modules.nixos;
        [
          # tim
        ];

      users.users."tim" = {
        isNormalUser = true;
        description = "Tim";
        hashedPassword = "$y$j9T$FmA6o8ge4bLcGWsnzo0Cf1$2woTOdh/E4Ukr2P0yY7HKCS9UuGDC0iDS2lsyB4Gc01";
        extraGroups = [
          "wheel" "vtune" "networkmanager"
        ];
      };

      

      # Add user secrets 

      home-manager.users.tim = {
        # User settings only for this host
        home.stateVersion = "25.05";
      };
    };
}