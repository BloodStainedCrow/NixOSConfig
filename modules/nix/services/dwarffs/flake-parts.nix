{
  inputs,
  ...
}:
{
  flake-file.inputs = {
    dwarffs = {
      url = "github:edolstra/dwarffs";
    };
  };

  imports = [ ];
}