# NixOS Configuration
This is the configuration for all of my NixOS machines, based on the [dendritic pattern](https://github.com/mightyiam/dendritic).

It exposes 3 system configurations, `TimsKleinerPC` for my desktop, `TimsLaptop` for my laptop and `NixOSNAS` for my homeserver.

It it manages my disk partitions using [disko](https://github.com/nix-community/disko) and keeps my files organized using [impermanence](https://github.com/nix-community/impermanence).
I have all my machines using zfs.

Secrets are managed using [sops-nix](https://github.com/Mic92/sops-nix).