{
  inputs,
  ...
}:
{
  flake.modules.nixos.install = {
    imports = with inputs.self.modules.nixos; [
      system-minimal
    ];
  };
}