{ globals, pkgs, ... }: {
  environment.localBinInPath = true;
  time = {
    timeZone = globals.localeinfo.timeZone;
    hardwareClockInLocalTime = true;
  };
  i18n.defaultLocale = globals.localeinfo.locale;
  security.pam.services.hyprlock = {};
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

}
