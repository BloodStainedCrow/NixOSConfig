{
  inputs,
  ...
}:
let
  username = "tim";
in
{
  flake.modules.homeManager.tim-work =
    { pkgs, config, ... }:
    {
      nixpkgs.config.allowUnfree = true;

      imports = with inputs.self.modules.homeManager; [
        system-cli
        work-browser
        office
        codium

        spotify
        obsidian
        mattermost
      ];
      home = {
        username = "${username}";
        packages = with pkgs; [
          wine
          ansifilter
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