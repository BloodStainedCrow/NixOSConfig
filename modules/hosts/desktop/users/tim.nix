{
  inputs,
  self,
  ...
}:
{
  flake.modules.nixos.TimsKleinerPC =
    { config, ... }:
    {
      imports =
        with inputs.self.modules.nixos;
        [
          tim
        ];

      

      # Add user secrets 

      home-manager.users.tim = {
        # User settings only for this host
      };
    };
}