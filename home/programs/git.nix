{ pkgs, config, ... }:
{
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    signing = {
      signByDefault = true;
      format = "openpgp";
    };
    settings = {
      user = {
        name = config.home.username;
        email = "dev@michaelpetersen.io";
      };

      commit.verbose = true;
      format.signOff = true;
      color.ui = true;
      pull.rebase = true;
      core.autocrlf = "input";

    };
    lfs.enable = true;
  };
  programs.diff-so-fancy = {
    enable = true;
    enableGitIntegration = true;
  };
}
