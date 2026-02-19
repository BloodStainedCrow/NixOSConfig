{
  inputs,
  ...
}:
{
  flake.modules.nixos.TimsLaptop = {
    imports = with inputs.self.modules.nixos; [
      system-desktop
      grub
      bluetooth
      disko

      nvidia-graphics

      impermanence
    ];


    networking.hostName = "TimsLaptop";
    networking.hostId = "5f4d3c76";

    services.xserver.xkb.layout = "de";
    console.keyMap = "de";

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
  };
}