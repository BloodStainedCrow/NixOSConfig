{
  inputs,
  ...
}:
{
  flake.modules.homeManager.browser =
    {
      pkgs,
      ...
    }:
    {
      nixpkgs.overlays = [
        inputs.firefox-addons.overlays.default
      ];

      # TODO: For now I will persist Firefox settings
      programs.firefox = {
        enable = true;
        profiles.default = {
          extensions.packages = with pkgs.firefox-addons; [
            ublock-origin
            istilldontcareaboutcookies

            hide-youtube-shorts

            dashlane
          ];

          settings = {
            "signon.rememberSignons" = false;
            # TODO:
            # "browser.translations.neverTranslateLanguages" = "[]";
          };
        };
      };
    };
}