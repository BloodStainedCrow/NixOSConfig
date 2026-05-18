# NixOS Configuration
This is the configuration for all of my NixOS machines, based on the [dendritic pattern](https://github.com/mightyiam/dendritic).

It exposes 3 system configurations, `TimsKleinerPC` for my desktop, `TimsLaptop` for my laptop and `NixOSNAS` for my homeserver.

It it manages my disk partitions using [disko](https://github.com/nix-community/disko) and keeps my files organized using [impermanence](https://github.com/nix-community/impermanence).
I have all my machines using zfs.

Secrets are managed using [sops-nix](https://github.com/Mic92/sops-nix).

Installing is done most easily using [nixos-anywhere](https://github.com/nix-community/nixos-anywhere/blob/92f82c5196a5f8588be4967e535c4cfd35e85902/docs/howtos/no-os.md#installing-on-a-machine-with-no-operating-system).

Just run `nix run github:nix-community/nixos-anywhere -- --flake '.#TimsLaptop' --target-host nixos@192.168.0.218` after setting a password in the installer.