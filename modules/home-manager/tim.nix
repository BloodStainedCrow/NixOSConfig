{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  nixpkgs = {
    overlays = [
      inputs.nur.overlay
    ];
    config = {
      allowUnfree = true;
    };
  };

  dconf = {
    enable = true;
    settings = {
      # Set Weather location (TODO: Weather seems to bit a bit broken)
      "org/gnome/Weather" = with lib.hm.gvariant; {
        locations = [
          (mkVariant (mkTuple [
            (mkUint32 2)
            (mkVariant (mkTuple [
              "Aachen"
              "ETNG"
              true
              [ (mkTuple [ 0.8895361479175408 0.10559241974565695 ]) ]
              [ (mkTuple [ 0.8862006317307619 0.10617904236054476 ]) ]
            ]))
          ]))
        ];
      };

      # Dark Mode!
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";

      "org/gnome/desktop/interface".enable-hot-corners = false;

      "org/gnome/mutter".edge-tiling = true;
    };
  };

  # TODO please change the username & home directory to your own
  home.username = "tim";
  home.homeDirectory = "/home/tim";

  home.persistence."/persist/user/tim" = {
    directories = [
      "NixOSConfig"
      "Downloads"
      "Music"
      "Pictures"
      "Documents"
      "Videos"
      "Games"

      # Steam
      # FIXME: Steam failed with steamwebhelper not responding and made the folder unresponsive
      # ".steam"
      ".local/share/Steam"

      # Firefox
      # TODO: The name of the profile is hardcoded!
      ".mozilla/firefox/default"

      # VSCodium
      ".config/VSCodium/User/globalStorage"

      # Discord
      ".config/discord"
      ".config/Electron"
    ];
    allowOther = true;
  };

  
  accounts.calendar.accounts."Personal" = {
    # name = "Radicale Personal";
    remote = {
        type = "caldav";
        userName = "tim";
        # TODO: This is likely wrong
        passwordCommand = "cat /run/secrets/radicale";
        # TODO: Get full path
        url = "https://radicale.local.aschhoff.de/tim/f70942c4-8004-ca9d-9a19-976e51357d08/";
    };
  };
  accounts.calendar.accounts."RWTH" = {
    # name = "Radicale RWTH";
    remote = {
        type = "caldav";
        userName = "tim";
        # TODO: This is likely wrong
        passwordCommand = "cat /run/secrets/radicale";
        # TODO: Get full path
        url = "https://radicale.local.aschhoff.de/tim/0ecbe4c0-bbd0-1d7d-310e-75dcb5fbc16c/";
    };
  };
  accounts.contact.accounts."radicale" = {
    name = "Radicale Contacts";
    remote = {
        type = "carddav";
        userName = "tim";
        # TODO: This is likely wrong
        passwordCommand = "cat /run/secrets/radicale";
        # TODO: Get full path
        url = "radicale.local.aschhoff.de";
    };
  };

  accounts.email.accounts."main" = {
    # TODO: I do not want this address in here I don't think
    address = "tim@aschhoff.de";
    # aliases = [
    #     # TODO:
    # ];
    # gpg = {
    #     # TODO:
    #     key = "";
    # };
    imap = {
        host = "imap.ionos.de ";
        port = 993;
    };
    
    smtp = {
      host = "smtp.ionos.de ";
      port = 465;
    };

    # flavor = "plain";

    userName = "tim@aschhoff.de";
    # TODO: 
    # passwordCommand = "cat /run/secrets/mail";
    
    realName = "Tim Aschhoff";

    thunderbird = {
        enable = true;
    };

    primary = true;

    # folders = {
    #     drafts = "Entwürfe";
    #     inbox = "Posteingang";
    #     sent = "Gesendet";
    #     trash = "Papierkorb";
    # };
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    discord
    element-desktop
    spotify
    lutris
    wine
  ];

  programs.bash = {
    enable = true;
    enableCompletion = true;

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      listall = "sudo fd --one-file-system --base-directory / --type f --hidden --exclude '{tmp,etc/passwd}'";
    };
  };

  # TODO: For now I will persist Firefox settings
  programs.firefox = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        # TODO:
        ublock-origin
        istilldontcareaboutcookies

        dashlane
      ];

      settings = {

      };
    };
  };

  programs.git = {
    enable = true;
    userName = "Tim Aschhoff";
    userEmail = "tim.aschhoff@t-online.de";

    extraConfig = {
      safe.directory = "*";
    };

    signing = {
        # TODO:
        signByDefault = false;
        # TODO:
        key = null;
    };
  };

  # TODO: gpg-agent
  programs.gpg = {
    enable = true;
    mutableKeys = false;
  };

  xdg.configFile."private-key" = {
    enable = true;
    # TODO: replace with correct sopsnix stuff
    # TODO: ENSURE this does not land in nix store!!!
    source = config.lib.file.mkOutOfStoreSymlink "/run/secrets/private.key";
    target = ".gnupg/private.key";
  };

  programs.spotify-player = {
    enable = true;
  };

  programs.thefuck = {
    enable = true;
  };

  programs.thunderbird = {
    enable = true;

    profiles = {
      "main" = {
        isDefault = true;
      };
    };

    settings =
      let
    cal = map (calendar: let
      safeName = builtins.replaceStrings [ "." ] [ "-" ] calendar.name;
      in {
        # TODO: Colours
        "calendar.registry.${safeName}.cache.enabled" = true;
        "calendar.registry.${safeName}.calendar-main-default" = calendar.primary;
        "calendar.registry.${safeName}.calendar-main-in-composite" = calendar.primary;
        "calendar.registry.${safeName}.name" = calendar.name;
        "calendar.registry.${safeName}.type" = "caldav";
        "calendar.registry.${safeName}.uri" = calendar.remote.url;
        "calendar.registry.${safeName}.username" = calendar.remote.userName;
      }) (builtins.attrValues config.accounts.calendar.accounts);
    in builtins.foldl' lib.recursiveUpdate { } cal;

  };

  programs.vscode = {
    enable = true;
    # TODO: Do I want this on?
    enableExtensionUpdateCheck = false;
    enableUpdateCheck = false;

    package = pkgs.vscodium;

    extensions = [
      pkgs.vscode-extensions.jnoortheen.nix-ide
    ];

    keybindings = [
        {
            key = "ctrl+d";
            command = "editor.action.deleteLines";
            when = "textInputFocus && !editorReadonly";
        }
    ];

    mutableExtensionsDir = false;
  };

  # TODO: Do I want automatic upgrades?
  services.home-manager.autoUpgrade.enable = false;

  

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
