{
  inputs,
  ...
}:
let
  hostname = "Tims-Predator-Laptop";
in
{
  flake.nixosConfigurations = inputs.self.lib.mkNixos "x86_64-linux" "${hostname}";

  flake.modules.nixos."${hostname}" = {
     imports = [ 
      inputs.self.modules.nixos.SimpleNixosPC
      {
        disko.swapsize = "16G";
        disko.device = "/dev/nvme0n1";
      }
    ];

     networking.hostName = "${hostname}";
     networking.hostId = (builtins.substring 0 8 (builtins.hashString "sha1" "${hostname}"));
  };
}