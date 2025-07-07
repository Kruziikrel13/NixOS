{
  inputs,
  pkgs,
  config,
  ...
}: let
  mkFirefoxModule = import "${inputs.home-manager.outPath}/modules/programs/firefox/mkFirefoxModule.nix";
in {
  imports = [
    (mkFirefoxModule {
      modulePath = [
        "programs"
        "zen-browser"
      ];
      name = "Zen Browser";
      wrappedPackageName = "zen-browser";
      unwrappedPackageName = "zen-browser-unwrapped";
      visible = true;
      platforms = {
        linux = {
          vendorPath = ".zen";
          configPath = ".zen";
        };
      };
    })
  ];

  programs.zen-browser = {
    enable = true;
    package = pkgs.wrapFirefox (inputs.zen-browser.packages.${pkgs.system}.zen-browser-unwrapped.override {
      policies = config.programs.zen-browser.policies;
    }) {};
    policies = {
      DisableAppUpdate = true;
      DisableTelemetry = true;
      ExtensionSettings = {
        "extension@tabliss-maintained" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/tablissng/latest.xpi";
          installation_mode = "force_installed";
        };
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
    profiles.kruziikrel13 = {
      id = 0;
      isDefault = true;
      name = "personal";
      path = "Profiles/home.personal";
      search.default = "ddg";
      bookmarks = {
        force = true;
        settings = [
          {
            name = "Github Repositories";
            bookmarks = [
              {
                name = "Kruziikrel13/NixOS";
                url = "https://github.com/Kruziikrel13/NixOS";
              }
              {
                name = "Kruziikrel13/sentinel.nvim";
                url = "https://github.com/Kruziikrel13/sentinel.nvim";
              }
              {
                name = "hyprwm/Hyprland";
                url = "https://github.com/hyprwm/Hyprland";
              }
              {
                name = "quickshell/quickshell";
                url = "https://git.outfoxxed.me/quickshell/quickshell";
              }
              {
                name = "futo-org/Grayjay.Desktop";
                url = "https://github.com/futo-org/Grayjay.Desktop";
              }
            ];
          }
          {
            name = "Nix Packages";
            bookmarks = [
              {
                name = "Home Manager: Appendix A";
                url = "https://nix-community.github.io/home-manager/options.html";
              }
              {
                name = "NixOS Packages Directory";
                url = "https://search.nixos.org/packages";
              }
            ];
          }
          {
            name = "Home - Student - QUT Portal";
            url = "https://qutvirtual4.qut.edu.au/group/student/home";
          }
        ];
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
