{inputs, lib, ...}: {
  flake.modules.nixos.pihole = { config, ... }: {
    imports = [
      inputs.self.modules.nixos.containers
      inputs.self.modules.nixos.pihole-settings
    ];

    virtualisation.oci-containers.containers = {
      # For logs see `journalctl -u podman-pihole.service | tail`
      pihole = {
        hostname = "pihole";
        # TODO: This is not flakified
        image = "pihole/pihole:latest";
        ports = [
          "${config.pihole.public-ip}:53:53/tcp"
          "${config.pihole.public-ip}:53:53/udp"
          "127.0.0.1:9999:80/tcp"
        ];
        environment = {
          TZ = "Europe/Berlin";

          # WEBPASSWORD_FILE = "${config.secrets."pihole/webpassword".path}";
        };
        volumes = [
          # "/path/on/host:/path/inside/container"
          "${config.pihole.storage-path}/etc:/etc/pihole"
          "${config.pihole.storage-path}/dnsmasq.d:/etc/dnsmasq.d"
        ];
        autoStart = true;
      };
    };
  };
}