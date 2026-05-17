{
  inputs,
  self,
  ...
}:
{
  flake.modules.nixos.install =
    { config, ... }:
    {
      imports =
        with inputs.self.modules.nixos;
        [
        ];
    };
}