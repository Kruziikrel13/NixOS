{
  pathLib,
  ...
}:
{
  imports = pathLib.scanPaths ./.;

  # Git explicitly required for flakes
  programs.git.enable = true;

  environment.stub-ld.enable = true;
  nixpkgs.config.allowUnfree = true;
  nix = {
    channel.enable = false;

    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      keep-derivations = true;
      keep-outputs = true;

      trusted-users = [
        "root"
        "@wheel"
      ];

      warn-dirty = false;
      accept-flake-config = false;
    };
  };
}
