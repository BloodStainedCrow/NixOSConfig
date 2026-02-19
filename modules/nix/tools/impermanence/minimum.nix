{
  flake.modules.nixos.impermanence =
    { config, ... }:
    {
      fileSystems."/persist/system".neededForBoot = true;
      # FIXME: Generalize
      fileSystems."/persist/user/tim".neededForBoot = true;
      environment.persistence."/persist/system" = {
        hideMounts = true;
        directories = [
          "/var/log"
          "/var/lib/nixos"
          "/var/lib/systemd/coredump"
          "/etc/NetworkManager/system-connections"
        ];
        files = [
          "/etc/machine-id"
        ];
      };

      programs.fuse.userAllowOther = true;

    };

}