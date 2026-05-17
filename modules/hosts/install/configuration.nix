{
  inputs,
  ...
}:
{
  flake.modules.nixos.install = {
    imports = with inputs.self.modules.nixos; [
      system-minimal
      disko
      grub
    ];

    # FIXME: This should not be in here. Prob this entire thing should be a flake option thingy
    networking.hostId = "5f4d3c76";
  };
}