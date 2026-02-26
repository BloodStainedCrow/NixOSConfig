{inputs, ...}:
{
  flake.modules.nixos.vtune = {pkgs, config, ...}: 
  let 
    intel-vtune-sepdk = (config.boot.kernelPackages.callPackage pkgs.localKernelModules.intel-vtune-sepdk {intel-oneapi-vtune = pkgs.intel-oneapi-vtune; });
  in
  {
    imports = [ ];

    nixpkgs.overlays = [
      inputs.self.overlays.localKernelModules
    ];

    environment.systemPackages = [
      pkgs.intel-oneapi-vtune
      intel-vtune-sepdk
    ];

    boot.extraModulePackages = [
      intel-vtune-sepdk
    ];


    users.groups.vtune = { };

    systemd.services.vtune-sep5 = {
      description = "Load VTune SEP5 driver";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${intel-vtune-sepdk}/bin/insmod-sep --load-in-tree-driver";
        ExecStop = "${intel-vtune-sepdk}/bin/rmmod-sep";
        RemainAfterExit = true;
      };
    };
  };
}