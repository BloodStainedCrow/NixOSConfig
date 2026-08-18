{
  inputs,
  self,
  ...
}:
{
  flake.modules.nixos.Tims-Work-Desktop =
    { config, ... }:
    {
      imports =
        with inputs.self.modules.nixos;
        [
          tim-work
        ];

      

      # Add user secrets 

      home-manager.users.tim = {
        # User settings only for this host

        nix = {
            experimental-features = [ "flakes" "nix-command" ];
        };
      };
    };
}