{
  flake.modules.homeManager.git =
    {
      config,
      ...
    }:
    {
      programs.git = {
        enable = true;
        lfs.enable = true;
        settings = {
          # Since the git config is read only, it is otherwise impossible to add a directory to be safe.
          # I consider this fine, since if I clone a repo I expect to want to build/run it anyway
          safe.directory = "*";

          # Sign all commits using ssh key
          commit.gpgsign = true;
          gpg.format = "ssh";
          user.signingkey = "~/.ssh/id_ed25519.pub";
          # gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";

          # FIXME: Make this into a setting somehow
          user = {
            name = "Tim Aschhoff";
            email = "tim@aschhoff.de";
          };
        };
      };

      # TODO: gpg-agent
      programs.gpg = {
        enable = true;
        mutableKeys = false;
        mutableTrust = false;
      };
    };

}