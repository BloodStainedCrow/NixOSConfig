{
  inputs, 
  ...
}:
{
  flake.modules.homeManager.codium =
    {
      pkgs,
      ...
    }:
    {
      programs.vscodium = {
        enable = true;
        # Downpatch vscodium as a work around for https://github.com/microsoft/vscode/issues/285769
        package = inputs.nixpkgs-codium.legacyPackages.${pkgs.stdenv.hostPlatform.system}.vscodium;

        profiles.default = {
          enableUpdateCheck = false;
          enableExtensionUpdateCheck = false;
          
          extensions = [
            pkgs.vscode-extensions.jnoortheen.nix-ide
            pkgs.vscode-extensions.gruntfuggly.todo-tree
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


