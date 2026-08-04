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

      users.users."admin" = {
        isNormalUser = true;
        description = "Admin";
        hashedPassword = "$y$j9T$FmA6o8ge4bLcGWsnzo0Cf1$2woTOdh/E4Ukr2P0yY7HKCS9UuGDC0iDS2lsyB4Gc01";
        extraGroups = [
          "wheel" "vtune" "networkmanager"
        ];
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID3jBccnyu9qNn8B9iDTUSCIedKUA5J/HJDOhoUMMRgM"
        ];
      };

      

      # Add user secrets 

      home-manager.users.admin = {
        imports = [
          # FIXME: This is borked because non-impermanence setups fail to build
          inputs.self.modules.homeManager.codium
        ];
        # User settings only for this host
        home.stateVersion = "25.05";
      };
    };
}