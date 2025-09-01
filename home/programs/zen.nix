{ inputs, ... }:
{
  imports = [ inputs.zen-browser.homeModules.twilight ];
  programs.zen-browser = {
    enable = true;
    policies = {
      DisableAppUpdate = true;
      DisableTelemetry = true;
      NoDefaultBookmarks = false;
      OfferToSaveLogins = false;
      ExtensionSettings = {
        "extension@tabliss-maintained" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/tablissng/latest.xpi";
          installation_mode = "force_installed";
        };
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
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
    };
    profiles.kruziikrel13 = {
      id = 0;
      isDefault = true;
      name = "personal";
      path = "Profiles/home.personal";
      search = {
        force = true;
        default = "ddg";
      };
      settings = {
        "zen.urlbar.replace-newtab" = false;
        "zen.view.sidebar-expanded" = false;
        "zen.view.use-single-toolbar" = false;
        "zen.view.show-newtab-button-top" = false;
      };
    };
  };
}
