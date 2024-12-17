# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
let
  # TODO: IIRC this is wrong
  device = "/dev/nvme0";
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/configuration.nix
      # Swapsize based on ubuntu recommendation (https://itsfoss.com/swap-size/)
      (import ../../modules/disko.nix { inherit device; swapsize = "38G"; })
    ];

  # Bootloader.
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
  };
  # boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "TimsKleinerPC"; # Define your hostname.
  networking.hostId = "310aa8dc";

  # TODO: Move this to the router
  networking.networkmanager.insertNameservers = [ "192.168.0.227" ];


  # Wipe / on every boot
  # TODO: Make sure that we keep potentially multiple backups instead of just one
  # According to https://github.com/NixOS/nixpkgs/issues/341542#issuecomment-2351276397 we should use postResumeCommands
  boot.initrd.postResumeCommands = lib.mkAfter ''
    zfs snapshot -r zroot/root@reboot

    zfs destroy zroot/backup

    zfs send -R zroot/root@reboot | zfs recv zroot/backup -o mountpoint=/lastboot

    zfs rollback -r zroot/root@blank
  '';

  fileSystems."/persist/system".neededForBoot = true;
  environment.persistence."/persist/system" = {
    hideMounts = true;
    directories = [
      "/etc/nixos"
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
    ];
    files = [
      "/etc/machine-id"
    ];
  };

  services.xserver.xkb.layout = "us";
  # The trailing comma is important, see https://github.com/NixOS/nixpkgs/issues/359830
  services.xserver.xkb.variant = "alt-intl,";
  console.keyMap = "us";

  # NVIDIA settings

  # "It is suggested to use the open source kernel modules on Turing or later GPUs (RTX series, GTX 16xx), and the closed source modules otherwise."
  hardware.nvidia.open = true;

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];
}
