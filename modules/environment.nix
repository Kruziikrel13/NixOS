{ config, pkgs, lib, ... }:
{
  security.pam.services.hyprlock = {};
  options = {
    opts.timeZone = mkOption {
      default = "Australia/Brisbane";
      type = str;
    };
  };
  config = {
    environment.localBinInPath = true;
    time = {
      timeZone = config.opts.timeZone;
      hardwareClockInLocalTime = true;
    };
    i18n.defaultLocale = "en_AU.UTF-8";
    programs = {
      nix-ld.enable = true;
      git.enable = true;
      neovim.enable = true;
      firefox.enable = true;

      ## Hyprland System Level Config
      uwsm.enable = true;
      hyprland = {
        enable = true;
        xwayland.enable = true;
        withUWSM = true;
      };
    };

    fonts = {
      packages = with pkgs.nerd-fonts; [ jetbrains-mono noto ];
      fontconfig.defaultFonts.monospace = [ "JetBrains Nerd Font Mono" ];
    };
  };
}
