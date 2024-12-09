# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.default
    inputs.sops-nix.nixosModules.sops
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # SOPS-NIX CONFIG

  # TODO: Do I want the keyfile here or somewhere else
  #sops.age.keyFile = "../secrets/keys.txt";
#
#
  #sops.secrets."wireless/environmentFile" = {
  #  sopsFile = ../secrets/wireless/environmentFile;
  #  format = "binary";
  #};
#
  ## networking.networkmanager.enable = true;
  ## networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  #networking.wireless.networks = {
  #  "@network1_uuid@" = {
  #    psk = "@network1_psk@";
  #  };
  #  "@network2_uuid@" = {
  #    psk = "@network2_psk@";
  #  };
  #  "@network3_uuid@" = {
  #    psk = "@network3_psk@";
  #  };
  #};
  #networking.wireless.environmentFile = "${config.sops.secrets."wireless/environmentFile".path}";

  # Reenable right click via button
  # services.xserver.desktopManager.gnome.extraGSettingsOverrides = ''
  #   [org.gnome.desktop.peripherals.touchpad]
  #   click-method='areas'
  # '';

  home-manager.backupFileExtension = "backup";

  programs.fuse.userAllowOther = true;

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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = with pkgs.gnome; [
    pkgs.baobab      # disk usage analyzer
    pkgs.cheese      # photo booth
    pkgs.eog         # image viewer
    pkgs.epiphany    # web browser
    pkgs.simple-scan # document scanner
    pkgs.totem       # video player
    pkgs.yelp        # help viewer
    pkgs.evince      # document viewer
    pkgs.file-roller # archive manager
    pkgs.geary       # email client
    pkgs.seahorse    # password manager

    # these should be self explanatory
    pkgs.gnome-calendar 

    pkgs.gnome-calculator 
    pkgs.gnome-characters
    pkgs.gnome-font-viewer 
    pkgs.gnome-logs 
    pkgs.gnome-maps
    pkgs.gnome-clocks
    pkgs.gnome-music
    pkgs.gnome-disk-utility 
    pkgs.pkgs.gnome-connections
  ];


  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  users.mutableUsers = false;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tim = {
    isNormalUser = true;
    description = "Tim";
    extraGroups = [ "wheel"
    "docker" ];
    # FIXME:
    password = "1234";
  };
  home-manager = {
    extraSpecialArgs = {inherit inputs; inherit pkgs;};
    users = {
        "tim" = import ./home-manager/tim.nix;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.steam = {
    enable = true;
    # remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    # dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    # localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
   # vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
   git
   lshw
   pciutils
   fd
  ];

  # enable swap to stop freezing on OOM
  zramSwap = {
    enable = true;
    algorithm = "lz4";
  };
  
  virtualisation.docker.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
