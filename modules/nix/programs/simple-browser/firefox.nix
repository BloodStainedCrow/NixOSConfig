{
  inputs,
  ...
}:
{
  flake.modules.homeManager.simple-browser =
    {
      pkgs,
      config,
      ...
    }:
    {
      nixpkgs.overlays = [
        inputs.firefox-addons.overlays.default
      ];

      programs.firefox = {
        enable = true;

        configPath = "${config.xdg.configHome}/mozilla/firefox";

        profiles.default = {
          extensions.packages = with pkgs.firefox-addons; [
            ublock-origin
            istilldontcareaboutcookies
          ];
        };
      };
    };
}