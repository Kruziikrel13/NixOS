{ pkgs, config, ... }:
{
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    signing = {
      signByDefault = true;
      format = "openpgp";
      key = "F34EB44630C65A33";
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
