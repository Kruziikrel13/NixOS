{
  lib,
  config,
  zen-browser,
  pkgs,
  ...
}:
let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf;
  cfg = config.modules.desktop.browsers.zen;
  package = zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  options.modules.desktop.browsers.zen = {
    enable = mkEnableOption "zen browser";
  };

  config = mkIf cfg.enable {
    programs.firefox = {
      inherit package;
      enable = true;
      policies = {
        DisableAppUpdate = true;
        DisableTelemetry = true;
        HardwareAcceleration = true;
        NoDefaultBookmarks = false;
        OfferToSaveLogins = false;
        SearchEngines.Default = "ddg";
        ExtensionSettings = {
          "extension@tabliss-maintained" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/tablissng/latest.xpi";
            installation_mode = "force_installed";
          };
          # Ublock
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "normal_installed";
            private_browsing = true;
          };
          # Bitwarden
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
            default_area = "navbar";
          };
        };
        preferences = {
          "zen.urlbar.replace-newtab" = false;
          "zen.view.sidebar-expanded" = false;
          "zen.view.use-single-toolbar" = false;
          "zen.view.show-newtab-button-top" = false;
        };
      };
    };
  };
}
