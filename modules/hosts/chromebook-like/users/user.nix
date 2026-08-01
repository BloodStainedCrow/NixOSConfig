{
  inputs,
  self,
  ...
}:
{
  flake.modules.nixos.SimpleNixosPC =
    { config, pkgs, ... }:
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

        home.file."Desktop/firefox.desktop".source = "${pkgs.firefox}/share/applications/firefox.desktop";
        home.file."Desktop/libreoffice-writer.desktop".source = "${pkgs.libreoffice}/share/applications/writer.desktop";
        home.file."Desktop/libreoffice-calc.desktop".source = "${pkgs.libreoffice}/share/applications/calc.desktop";

        home.stateVersion = "25.05";
      };
    };
}