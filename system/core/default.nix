{
  lib,
  paths,
  ...
}: {
  imports = paths.scanPaths ./.;

  programs.nix-ld.enable = true;
  environment.stub-ld.enable = true;
  documentation = {
    nixos.enable = false;
    dev.enable = true;
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocales = ["en_US.UTF-8/UTF-8" "en_AU.UTF-8/UTF-8" "ru_RU.UTF-8/UTF-8" "nl_NL.UTF-8/UTF-8"];
  };

  time.timeZone = lib.mkDefault "Australia/Brisbane";
  system.stateVersion = lib.mkDefault "24.11";
}
