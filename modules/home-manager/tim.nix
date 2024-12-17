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

      ".ssh"

      # Steam
      # FIXME: Steam failed with steamwebhelper not responding and made the folder unresponsive when using .steam
      # The cause seems that steam DOES NOT like running on fuse (i.e. the mount used bzy home manager impermanence)
      # I fixed this by using symlink here
      {directory = ".local/share/Steam"; method = "symlink";}

      # Firefox
      # TODO: The name of the profile is hardcoded!
      ".mozilla/firefox/default"

      # VSCodium
      ".config/VSCodium/User/globalStorage"

      # Discord
      ".config/discord"
      ".config/Electron"

      # Factorio saves
      ".factorio"
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
        url = "https://radicale.local.aschhoff.de/tim/8c529332-66c7-476d-23d8-dae20e952694/";
    };
  };

  accounts.email = {
    accounts."tim@aschhoff.de" = {
      address = "tim@aschhoff.de";
      # aliases = [
      #     # TODO:
      # ];
      # gpg = {
      #     # TODO:
      #     key = "";
      # };
      imap = {
        host = "imap.ionos.de";
        port = 993;
        tls = {
        enable = true;
          useStartTls = false;
        };
      };
      
      smtp = {
        host = "smtp.ionos.de";
        port = 465;
        tls = {
          enable = true;
          useStartTls = true;
        };
      };

      userName = "tim@aschhoff.de";
      # TODO: 
      # passwordCommand = "cat /run/secrets/mail";
      
      realName = "Tim Aschhoff";

      thunderbird = {
          enable = true;
      };

      primary = true;
    };
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    discord
    element-desktop
    spotify
    lutris
    wine
    obsidian
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
        ublock-origin
        istilldontcareaboutcookies

        dashlane
      ];

      settings = {
        "signon.rememberSignons" = false;
        # TODO:
        # "browser.translations.neverTranslateLanguages" = "[]";
      };
    };
  };

  # # TODO: This is needed to locally verify the commit signing
  # # TODO: This path is hardcoded relative to the home dir!
  # home.file.".ssh/allowed_signers".text =
  #   "* ${builtins.readFile /home/tim/.ssh/id_ed25519.pub}";

  programs.git = {
    enable = true;
    userName = "Tim Aschhoff";
    userEmail = "tim@aschhoff.de";

    extraConfig = {
      # Since the git config is read only, it is otherwise impossible to add a directory to be safe.
      # I consider this fine, since if I clone a repo I expect to want to build/run it anyway
      safe.directory = "*";

      # Sign all commits using ssh key
      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = "~/.ssh/id_ed25519.pub";
      # gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
    };
  };

  # TODO: gpg-agent
  programs.gpg = {
    enable = true;
    mutableKeys = false;
  };

  # xdg.configFile."private-key" = {
  #   enable = true;
  #   # TODO: replace with correct sopsnix stuff
  #   # TODO: ENSURE this does not land in nix store!!!
  #   source = config.lib.file.mkOutOfStoreSymlink "/run/secrets/private.key";
  #   target = ".gnupg/private.key";
  # };

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
