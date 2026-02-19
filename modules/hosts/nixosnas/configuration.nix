{
  inputs,
  ...
}:
{
  flake.modules.nixos.NixOSNAS = {config, ... }: {
    imports = with inputs.self.modules.nixos; [
      system-cli
      grub
      pihole {
        pihole.public-ip = "192.168.0.168";
        pihole.storage-path = "/mnt/tank/pihole";
      }
    ];



    networking.hostName = "NixOSNAS";
    # Generated via "head -c4 /dev/urandom | od -A none -t x4"
    networking.hostId = "3c0de582";

    # Set your time zone.
    # time.timeZone = "Europe/Berlin";

    time.timeZone = "${config.pihole.public-ip}";
  };
}