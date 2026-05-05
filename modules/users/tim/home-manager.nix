{
  inputs,
  ...
}:
let
  username = "tim";
in
{
  flake.modules.homeManager."${username}" =
    { pkgs, config, ... }:
    {
      nixpkgs.config.allowUnfree = true;

      imports = with inputs.self.modules.homeManager; [
        system-desktop

        discord
        steam
        archipelago
        spotify
        factory_game
        minecraft
        ninjabrain-bot
        # Factorio (since its non-free) must be installed using some token shenanigans
        # factorio
        obsidian
      ];
      home = {
        username = "${username}";
        packages = with pkgs; [
          wine
          ansifilter
        ];

        persistence = inputs.self.lib.addPersistedFolders config [
          "NixOSConfig"
          "Downloads"
          "Music"
          "Pictures"
          # Fusemounts seem to have terrible performance, which results in compiles
          # (from Documents/Programming) to fail with weird errors (out of filedescriptors etc)
          # Using a symlink instead seems to work better
          # TODO: Everything seems to use some specific mount now. Evalutate if this is fine
          "Documents"
          "Videos"
          "Games"

          ".ssh"
        ];
      };

      programs.nushell = {
        enable = true;
      };

      programs.pay-respects = {
        enable = true;
      };
    };
}