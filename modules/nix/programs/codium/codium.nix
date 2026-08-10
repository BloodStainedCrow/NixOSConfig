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
    let
      pkgs-codium = inputs.nixpkgs-codium.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      programs.vscodium = {
        enable = true;
        # Downpatch vscodium as a work around for https://github.com/microsoft/vscode/issues/285769
        package = pkgs-codium.vscodium;

        profiles.default = {
          enableUpdateCheck = false;
          enableExtensionUpdateCheck = false;
          
          extensions = [
            pkgs-codium.vscode-extensions.jnoortheen.nix-ide
            pkgs-codium.vscode-extensions.gruntfuggly.todo-tree
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


