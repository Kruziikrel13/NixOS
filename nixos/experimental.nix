{
  pkgs,
  ...
}: {
  # An "improved" version of the nix package manager that is more community focussed
  nix.package = pkgs.lix;

  # NIX Cli Helper
  programs.nh = {
    enable = true;
    clean.enable = true;
  };
}
