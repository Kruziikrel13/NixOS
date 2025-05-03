{ 
globals, 
pkgs,
...
}: {
  time = {
    timeZone = globals.localeinfo.timeZone;
    hardwareClockInLocalTime = true;
  };
  i18n.defaultLocale = globals.localeinfo.locale;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = globals.localeinfo.locale;
    LC_IDENTIFICATION = globals.localeinfo.locale;
    LC_MEASUREMENT = globals.localeinfo.locale;
    LC_MONETARY = globals.localeinfo.locale;
    LC_NAME = globals.localeinfo.locale;
    LC_NUMERIC = globals.localeinfo.locale;
    LC_PAPER = globals.localeinfo.locale;
    LC_TELEPHONE = globals.localeinfo.locale;
    LC_TIME = globals.localeinfo.locale;
  };
  fonts = {
    packages = with pkgs.nerd-fonts; [ jetbrains-mono noto ];
    fontconfig.defaultFonts.monospace = [ "JetBrains Nerd Font Mono" ];
  };
  console.useXkbConfig = true;
}
