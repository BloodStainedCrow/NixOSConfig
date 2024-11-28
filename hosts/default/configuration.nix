# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
let 
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
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "TimsKleinerPC"; # Define your hostname.
  networking.hostId = "310aa8dc";

  home-manager.backupFileExtension = "backup";


  # Wipe / on every boot
  # TODO: Make sure that we keep potentially multiple backups instead of just one
  # According to https://github.com/NixOS/nixpkgs/issues/341542#issuecomment-2351276397 we should use postResumeCommands
  boot.initrd.postResumeCommands = lib.mkAfter ''
    zfs destroy zroot/root@reboot

    zfs snapshot zroot/root@reboot

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

  programs.fuse.userAllowOther = true;

  services.xserver.xkb.layout = "us";
  # The trailing comma is important, see https://github.com/NixOS/nixpkgs/issues/359830
  services.xserver.xkb.variant = "alt-intl,";
  console.keyMap = "us";
#
  ## NVIDIA settings
#
  ## Enable OpenGL
  #hardware.opengl = {
  #  enable = true;
  #};
#
  ## Load nvidia driver for Xorg and Wayland
  #services.xserver.videoDrivers = ["nvidia"];
#
  #hardware.nvidia = {
#
  #  # Modesetting is required.
  #  modesetting.enable = true;
#
  #  # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
  #  # Enable this if you have graphical corruption issues or application crashes after waking
  #  # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
  #  # of just the bare essentials.
  #  powerManagement.enable = false;
#
  #  # Fine-grained power management. Turns off GPU when not in use.
  #  # Experimental and only works on modern Nvidia GPUs (Turing or newer).
  #  powerManagement.finegrained = false;
#
  #  # Use the NVidia open source kernel module (not to be confused with the
  #  # independent third-party "nouveau" open source driver).
  #  # Support is limited to the Turing and later architectures. Full list of 
  #  # supported GPUs is at: 
  #  # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
  #  # Only available from driver 515.43.04+
  #  # Currently alpha-quality/buggy, so false is currently the recommended setting.
  #  open = false;
#
  #  # Enable the Nvidia settings menu,
  #  # accessible via `nvidia-settings`.
  #  nvidiaSettings = true;
#
  #  # Optionally, you may need to select the appropriate driver version for your specific GPU.
  #  package = config.boot.kernelPackages.nvidiaPackages.stable;
  #};
#
  #hardware.nvidia.prime = {
  #      # Make sure to use the correct Bus ID values for your system!
  #      intelBusId = "PCI:0:2:0";
  #      nvidiaBusId = "PCI:1:0:0";
  #};

}
