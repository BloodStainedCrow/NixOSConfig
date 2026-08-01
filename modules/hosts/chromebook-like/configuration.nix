{
  inputs,
  ...
}:
{
  flake.modules.nixos.SimpleNixosPC = {
    imports = with inputs.self.modules.nixos; [
      system-simple-desktop
      auto-upgrade
      grub {
        grub.hide = true;
      }

      nvidia-graphics

      wifi

      disko
      ssh
    ];
    users.mutableUsers = false;

    # Enable plymouth to hide the "scary" boot logs
    boot.plymouth.enable = true;

    # Enable "Silent boot" (See https://wiki.nixos.org/wiki/Plymouth and https://wiki.archlinux.org/title/Silent_boot)
    # IF a system fails to boot, using `e` on a boot entry in grub allows removing the quiet flags
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "rd.udev.log_level=3"
      "rd.systemd.show_status=auto"
    ];


    services.xserver.xkb.layout = "de";
    console.keyMap = "de";

    # Set your time zone.
    time.timeZone = "Europe/Berlin";

    # Select internationalisation properties.
    i18n.defaultLocale = "de_DE.UTF-8";

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
  };
}