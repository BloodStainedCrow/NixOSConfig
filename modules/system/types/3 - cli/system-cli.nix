{
  inputs,
  ...
}:
{
  # expansion of default system with basic system settings & cli-tools

  flake.modules.nixos.system-cli = {
    imports = with inputs.self.modules.nixos; [
      system-default

      ssh
      firmware
      cli-tools
      nix-index
    ];
  };

  flake.modules.homeManager.system-cli = {
    imports = with inputs.self.modules.homeManager; [
      system-default
      shell
      git
    ];
  };
}