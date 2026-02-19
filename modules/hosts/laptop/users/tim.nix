{
  inputs,
  self,
  ...
}:
{
  flake.modules.nixos.TimsLaptop =
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