{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.opts;
in {
  config = {
    programs = {
      git.enable = true;
      zsh.enable = true;
    };

    environment.systemPackages = [pkgs.home-manager];

    services.kmscon = {
      enable = true;
      hwRender = true;
      extraConfig = ''
        font-size=14
        font-name=UbuntuMono Nerd Font Mono
      '';
      extraOptions = "--term xterm-256color";
    };

    environment.localBinInPath = true;

    time.timeZone = "Australia/Brisbane";
    time.hardwareClockInLocalTime = true;
    i18n.defaultLocale = "en_AU.UTF-8";

    fonts = {
      packages = [(pkgs.nerdfonts.override {fonts = ["UbuntuMono" "Noto"];})];
      fontDir = {
        decompressFonts = true;
      };
      fontconfig.defaultFonts.monospace = ["UbuntuMono Nerd Font Mono"];
    };
  };
}
