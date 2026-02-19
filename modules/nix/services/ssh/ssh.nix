{
  flake.modules.nixos.ssh = {
    services.openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
  };

  # TODO: Add easy way to add public key
}