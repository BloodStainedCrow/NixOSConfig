{
  # Modules to help you handle persistent state on systems with ephemeral root storage
  # https://github.com/nix-community/impermanence

  flake-file.inputs = {
    # impermanence.url = "github:nix-community/impermanence";
    
    # Use the old home dir to persist mapping
    # See https://github.com/nix-community/impermanence/issues/296
    impermanence.url = "github:Musholic/impermanence/home_suffix_fix";
  };
}