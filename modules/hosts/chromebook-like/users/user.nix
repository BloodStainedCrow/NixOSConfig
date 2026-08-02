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

        # FIXME: Since the locale is german, the "Desktop" folder is called "Schreibtisch"
        home.file."Schreibtisch/firefox.desktop".source = "${pkgs.firefox}/share/applications/firefox.desktop";
        home.file."Schreibtisch/libreoffice-writer.desktop".source = "${pkgs.libreoffice}/share/applications/writer.desktop";
        home.file."Schreibtisch/libreoffice-calc.desktop".source = "${pkgs.libreoffice}/share/applications/calc.desktop";
        home.file."Schreibtisch/kmail.desktop".source = "${pkgs.kdePackages.kmail}/share/applications/calc.desktop";

        home.stateVersion = "25.05";
      };
    };
}