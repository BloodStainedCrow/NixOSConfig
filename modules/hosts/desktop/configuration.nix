{
  inputs,
  ...
}:
{
  flake.modules.nixos.TimsKleinerPC = {pkgs, ...}: {
    imports = with inputs.self.modules.nixos; [
      system-desktop
      grub
      bluetooth
      disko
      {
        # TODO: Grub does not want this for UEFI I believe
        disko.device = "/dev/nvme0n1";
        disko.swapsize = "64G";
      }

      nvidia-graphics

      impermanence

      factory_game_dedicated_server

      # vtune
    ];

    # FIXME: This is for factorio UPS
    boot.kernelParams = [
      "hugepagesz=1G"
      "hugepages=4"
    ];

    boot.extraModprobeConfig = ''
      options nvidia NVreg_RestrictProfilingToAdminUsers=0
    '';

    networking.hostName = "TimsKleinerPC";
    networking.hostId = "310aa8dc";

    # Set keyboard layout to US-International
    services.xserver.xkb.layout = "us";
    # The trailing comma is important, see https://github.com/NixOS/nixpkgs/issues/359830
    services.xserver.xkb.variant = "alt-intl,";
    console.keyMap = "us";

    # Set your time zone.
    time.timeZone = "Europe/Berlin";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "de_DE.UTF-8";
      LC_IDENTIFICATION = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "de_DE.UTF-8";
      LC_NUMERIC = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };

    # FIXME: After a suspend I have major (seemingly memory) corruption.
    # Disable the GNOME3/GDM auto-suspend feature
    systemd.targets.sleep.enable = false;
    systemd.targets.suspend.enable = false;
    systemd.targets.hibernate.enable = false;
    systemd.targets.hybrid-sleep.enable = false;
    
    # TODO:
    nixpkgs.config.allowUnfree = true;
  };
}