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
        # codium does not work on non-nixos due to chromium jank
        # codium

        spotify
        obsidian
        # mattermost does not work on non-nixos due to chromium jank
        # mattermost

        bash
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


      nix = {
        package = pkgs.nix;
        settings = {
          experimental-features = [ "flakes" "nix-command" ];
        };
      };

      git.email = "tim.aschhoff@canonical.com";
    };
}