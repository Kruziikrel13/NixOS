{
  lib,
  lib',
  config,
  pkgs,
  ...
}:

let
  inherit (lib'.options) mkBoolOpt;
  cfg = config.modules.desktop;
in
{
  options.modules.desktop = {
    enable = mkBoolOpt false;
  };

  config = with lib; {
    assertions =
      let
        isEnabled = _: v: v.enable or false;
        hasDesktopEnabled =
          cfg: (anyAttrs isEnabled cfg) || !(anyAttrs (_: v: isAttrs v && anyAttrs isEnabled v) cfg);
      in
      [
        {
          assertion = (countAttrs isEnabled cfg) < 2;
          message = "Can't have more than one desktop environment enabled at a time";
        }
        {
          assertion = hasDesktopEnabled cfg;
          message = "Can't enable a desktop sub-module without a desktop environment";
        }
      ];

    # TODO: Verify what's actually needed here
    fonts = {
      fontDir.enable = true;
      enableGhostscriptFonts = true;
      enableDefaultPackages = false;
      packages = with pkgs; [
        material-symbols

        libertinus
        noto-fonts
        noto-fonts-cjk-sans
        roboto
        (google-fonts.override { fonts = [ "Inter" ]; })

        jetbrains-mono

        nerd-fonts.jetbrains-mono
        nerd-fonts.symbols-only
      ];
      fontconfig.defaultFonts = {
        serif = [ "Libertinus Serif" ];
        sansSerif = [ "Inter" ];
        monospace = [ "Jetbrains Mono Nerd Font" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };

    environment.systemPackages = with pkgs; [ libnotify ];

    # Improves latency and reduces stuttering in high load scenarios
    security.pam.loginLimits = [
      {
        domain = "@users";
        item = "rtprio";
        type = "-";
        value = 1;
      }
    ];
  };
}
