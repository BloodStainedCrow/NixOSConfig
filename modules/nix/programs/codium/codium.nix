{
  flake.modules.homeManager.codium =
    {
      pkgs,
      ...
    }:
    {
      programs.vscode = {
        enable = true;

        package = pkgs.vscodium;

        profiles.default = {
          enableUpdateCheck = false;
          enableExtensionUpdateCheck = false;
          
          extensions = [
            pkgs.vscode-extensions.jnoortheen.nix-ide
            # These are broken due to beam stuff 
            # pkgs.open-vsx.jeanp413.open-remote-ssh
            # pkgs.vscode-marketplace.yy0931.save-as-root
          ];

          keybindings = [
              {
                  key = "ctrl+d";
                  command = "editor.action.deleteLines";
                  when = "textInputFocus && !editorReadonly";
              }
          ];
        };

        mutableExtensionsDir = false;
      };
    };
}


