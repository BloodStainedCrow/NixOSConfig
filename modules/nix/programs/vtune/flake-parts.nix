{
  inputs,
  withSystem,
  ...
}:
{
  flake-file.inputs = {
    intel-vtune-sepdk = {
      url = "path:./kernelModules/intel-vtune-sepdk";
      flake = false;
    };

    intel-oneapi-vtune = {
      url = "path:./packages-custom/intel-oneapi-vtune/package.nix";
      flake = false;
    };

    old-nixpkgs = {
      url = "github:nixos/nixpkgs/23.05";
    };
  };

  imports = [
  ];

  flake =
  {
    overlays.localKernelModules = _final: prev: 
    let
      old-nixpkgs = import inputs.old-nixpkgs {
        system = prev.stdenv.hostPlatform.system;
      };
    in
    {
      localKernelModules.intel-vtune-sepdk = inputs.intel-vtune-sepdk;

      intel-oneapi-vtune = prev.callPackage inputs.intel-oneapi-vtune { 
        libsafec = prev.local.libsafec; 
        opencl-clang = old-nixpkgs.opencl-clang;
        readline = old-nixpkgs.readline63;
      };
    };
  };

}