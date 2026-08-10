{
  inputs,
  ...
}:
{
  # TODO: Clean this up
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

        # Keep legacy behaviour from 25.11
        configPath = ".mozilla/firefox";

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

  flake.modules.homeManager.work-browser =
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

        # Keep legacy behaviour from 25.11
        configPath = ".mozilla/firefox";

        profiles.default = {
          extensions.packages = with pkgs.firefox-addons; [
            ublock-origin
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