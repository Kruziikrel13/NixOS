{
  zen-browser-unwrapped,
  wrapFirefox,

  lib,
  useGlance ? false,
  glanceUrl ? "127.0.0.1:8080",
}:
wrapFirefox zen-browser-unwrapped {
  pname = "zen-browser-custom";

  extraPolicies = {
    CaptivePortal = false;
    DisablePocket = true;
    DisableTelemetry = true;
    NoDefaultBookmarks = false;
    OfferToSaveLogins = false;
    SearchEngines = {
      Add = [
        {
          Name = "DuckDuckGo";
          URLTemplate = "https://duckduckgo.com/?q={searchTerms}";
          Alias = "ddg";
        }
      ];
      Default = "DuckDuckGo";
    };
    ExtensionSettings = {
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
    }
    // (
      if !useGlance then
        {
          "extension@tabliss-maintained" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/tablissng/latest.xpi";
            installation_mode = "force_installed";
          };
        }
      else
        {
          "newtaboverride@agenedia.com" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/new-tab-override/latest.xpi";
            installation_mode = "force_installed";
          };
        }
    );
  };

  extraPrefs = ''
    lockPref("zen.urlbar.replace-newtab", false);
    lockPref("zen.view.sidebar-expanded", false);
    lockPref("zen.view.use-single-toolbar", false);
    lockPref("zen.view.show-newtab-button-top", false);
    lockPref("zen.welcome-screen.seen", true);
  ''
  + lib.optionalString useGlance ''
    lockPref("browser.startup.homepage", "http://${glanceUrl}");
  '';
}
