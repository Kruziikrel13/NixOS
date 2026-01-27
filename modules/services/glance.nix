{
  lib,
  lib',
  config,
  ...
}:
let
  inherit (lib'.options) mkBoolOpt;
  cfg = config.modules.services.glance;
in
{
  options.modules.services.glance.enable = mkBoolOpt false;
  config = lib.mkIf cfg.enable {
    services.glance = {
      enable = true;
      settings = {
        server.port = 8080;
        pages = [
          {
            name = "Home";
            columns = [
              {
                size = "small";
                widgets = [
                  {
                    type = "search";
                    search-engine = "duckduckgo";
                    autofocus = true;
                    bangs = [
                      {
                        title = "Nixpkgs";
                        shortcut = "@np";
                        url = "https://search.nixos.org/packages?query={QUERY}";
                      }
                      {
                        title = "NixOS Options";
                        shortcut = "@no";
                        url = "https://search.nixos.org/options?query={QUERY}";
                      }
                      {
                        title = "NixOS Wiki";
                        shortcut = "@nw";
                        url = "https://wiki.nixos.org/w/index.php?search={QUERY}";
                      }
                      {
                        title = "noogle";
                        url = "https://noogle.dev/q?term={QUERY}";
                        shortcut = "@ng";
                      }
                    ];
                  }
                  {
                    type = "group";
                    widgets = [
                      {
                        type = "clock";
                        hour-format = "24h";
                        timezones = [
                          {
                            timezone = "Australia/Brisbane";
                            label = "Brisbane";
                          }
                          {
                            timezone = "America/Los_Angeles";
                            label = "Washington";
                          }
                          {
                            timezone = "Europe/Stockholm";
                            label = "Stockholm";
                          }
                        ];
                      }
                      {
                        type = "weather";
                        units = "metric";
                        hour-format = "24h";
                        location = "Sunshine Coast, Australia";
                      }
                    ];
                  }
                  {
                    type = "twitch-channels";
                    channels = [
                      "st1mpee"
                      "jerma985"
                      "generalsam123"
                      "papapoob"
                    ];
                  }
                ];
              }
              {
                size = "full";
                widgets = [
                  {
                    type = "group";
                    widgets = [
                      {
                        type = "videos";
                        size = "full";
                        style = "grid-cards";
                        channels = [
                          "UCedicLbmN_7vPUmPXlvKPFg" # General Sam
                          "UCNqHkzC_AlCPMwjTOSblkaA" # Forehead Fables Podcast
                          "UC2MjZanWOfyfsrHOyitmXbQ" # Stimpee
                          "UCyMnHssVup_wBZRnCSMVt3w" # CHRBRG
                          "UC5wZGwqyPawfmzpve8aJ-hw" # Geopold
                          "UCCCmapQ-VnHWNZlK1Jdnalg" # Gattsu
                          "UCD6VugMZKRhSyzWEWA9W2fg" # Sseth Tzeentach
                          "UClOGLGPOqlAiLmOvXW5lKbw" # Mandalore Gaming
                          "UCnHEz9DZ6EAof1-DaQGD_Xw" # PPPeter
                          "UCq-xCE4xUr7RpvzjyVmYxqA" # PoobTube
                          "UC_lv3DF67KdqvLb_vc-mmIQ" # Seneral Gam
                          "UC4Yjz30lM86xeqbHOhPqlmw" # Bizzlesnaff
                          "UC_S45UpAYVuc0fYEcHN9BVQ" # Boy Boy
                          "UCNMSCL9rDJJez6mP5gSpAPQ" # Bed Bananas
                          "UCJYJgj7rzsn0vdR7fkgjuIA" # Styro Pyro
                        ];
                      }
                      {
                        type = "reddit";
                        style = "vertical-cards";
                        subreddit = "gamingnews";
                        show-thumbnails = true;
                      }
                    ];
                  }
                ];
              }
            ];
          }
          {
            name = "Developer";
            columns = [
              {
                size = "small";
                widgets = [
                  {
                    type = "group";
                    widgets = [
                      {
                        type = "server-stats";
                        servers = [
                          {
                            type = "local";
                            cpu-temp-sensor = true;
                            name = "${config.networking.hostName}";
                          }
                        ];
                      }
                      {
                        type = "monitor";
                        cache = "1m";
                        title = "Services";
                        sites = [
                          {
                            title = "Steam";
                            url = "https://steamcommunity.com";
                          }
                          {
                            title = "NixOS";
                            url = "https://cache.nixos.org";
                          }
                          {
                            title = "GitHub";
                            url = "https://github.com";
                          }
                          {
                            title = "Cloudflare";
                            url = "https://cloudflare.com";
                          }
                          {
                            title = "Youtube";
                            url = "https://youtube.com";
                          }
                        ];
                      }
                    ];
                  }
                  {
                    type = "releases";
                    show-source-icon = true;
                    repositories = [
                      "hyprwm/hyprland"
                      "quickshell-mirror/quickshell"
                      "folke/lazy.nvim"
                      "folke/snacks.nvim"
                    ];
                  }
                  {
                    title = "Grayjay Desktop";
                    type = "rss";
                    style = "vertical-list";
                    limit = 1;
                    feeds = [
                      {
                        url = "https://gitlab.futo.org/videostreaming/Grayjay.Desktop/-/tags?format=atom";
                      }
                    ];
                  }
                  {
                    type = "group";
                    widgets = [
                      {
                        title = "Barnacle";
                        type = "repository";
                        repository = "poperigby/barnacle";
                      }
                      {
                        title = "My NixOS";
                        type = "repository";
                        repository = "kruziikrel13/NixOS";
                        pull-requests-limit = 0;
                        issues-limit = 3;
                      }
                      {
                        title = "Nixpkgs";
                        type = "repository";
                        repository = "nixos/nixpkgs";
                      }
                    ];
                  }
                ];
              }
              {
                size = "full";
                widgets = [
                  {
                    type = "group";
                    widgets = [
                      {
                        type = "videos";
                        size = "full";
                        style = "grid-cards";
                        channels = [
                          "UCsBjURrPoezykLs9EqgamOA"
                          "UC-9b7aDP6ZN0coj9-xFnrtw"
                          "UCsXVk37bltHxD1rDPwtNM8Q"
                          "UCJXa3_WNNmIpewOtCHf3B0g"
                          "UC5UAwBUum7CPN5buc-_N1Fw"
                          "UCUMwY9iS8oMyWDYIe6_RmoA"
                        ];
                      }
                      {
                        type = "reddit";
                        subreddit = "neovim";
                        show-thumbnails = true;
                      }
                    ];
                  }
                ];
              }
            ];
          }
        ];
      };
    };
  };
}
