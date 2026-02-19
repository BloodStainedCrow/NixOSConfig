{
  inputs,
  ...
}:
{
  flake.modules.nixos.gnome = 
  { pkgs, ... }:
  {
    home-manager.sharedModules = [
      inputs.self.modules.homeManager.gnome
    ];

    # Enable the GNOME Desktop Environment.
    services = {
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    programs.dconf.enable = true;

    environment.gnome.excludePackages = with pkgs.gnome; [
        pkgs.baobab      # disk usage analyzer
        pkgs.cheese      # photo booth
        pkgs.eog         # image viewer
        pkgs.epiphany    # web browser
        pkgs.simple-scan # document scanner
        pkgs.totem       # video player
        pkgs.yelp        # help viewer
        pkgs.evince      # document viewer
        pkgs.file-roller # archive manager
        # pkgs.geary       # email client
        pkgs.seahorse    # password manager

        # these should be self explanatory
        # pkgs.gnome-calendar 

        pkgs.gnome-characters
        pkgs.gnome-font-viewer 
        pkgs.gnome-logs 
        pkgs.gnome-maps
        pkgs.gnome-clocks
        pkgs.gnome-music
        pkgs.pkgs.gnome-connections
      ];
  };

  flake.modules.homeManager.gnome = { lib, ... }: {
    dconf.settings = {
      # Dark Mode!
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";

      "org/gnome/desktop/interface".enable-hot-corners = false;

      "org/gnome/mutter".edge-tiling = true;
      
      "org/nemo/preferences" = {
        confirm-move-to-trash = true;
      };

      "org/gnome/mutter".workspaces-only-on-primary = false;
    };
  };
}