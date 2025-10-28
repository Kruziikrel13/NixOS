{ pkgs, config, ... }:
{
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    settings = {
      user.name = config.home.username;
      user.email = "dev@michaelpetersen.io";

      signing.key = "";
      signing.signByDefault = true;

      color.ui = true;
      commit.verbose = true;

      pull.rebase = true;
      core.autocrlf = "input";

      format.signOff = true;
    };
    lfs.enable = true;
  };
  programs.diff-so-fancy = {
    enable = true;
    enableGitIntegration = true;
  };
}
