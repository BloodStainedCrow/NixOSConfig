{
  inputs,
  ...
}:
{
  flake.modules.nixos.SimpleNixosPC = {
    imports = with inputs.self.modules.nixos; [
      system-simple-desktop
      grub {
        grub.hide = true;
      }

      nvidia-graphics

      wifi

      disko
      ssh
    ];

    # Since we do not have grub time, have this to help the nvme get found
    # See https://www.reddit.com/r/zfs/comments/nijszx/newly_created_pool_doesnt_import_on_boot/
    boot.kernelParams = [ "rootdelay=10" ];

    users.mutableUsers = false;


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