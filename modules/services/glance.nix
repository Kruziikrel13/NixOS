{
  lib,
  lib',
  config,
  ...
}:
let
  inherit (lib'.options) mkOpt mkBoolOpt;
  cfg = config.modules.services.glance;
in
{
  options.modules.services.glance = {
    enable = mkBoolOpt false;
    enableFirewall = mkBoolOpt false;
  };

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
                size = "full";
                widgets = [
                  {
                    type = "videos";
                    size = "full";
                    style = "grid-cards";
                    channels = [
                      "UCedicLbmN_7vPUmPXlvKPFg"
                      "UCNqHkzC_AlCPMwjTOSblkaA"
                      "UC2MjZanWOfyfsrHOyitmXbQ"
                      "UCyMnHssVup_wBZRnCSMVt3w"
                      "UC5wZGwqyPawfmzpve8aJ-hw"
                      "UCCCmapQ-VnHWNZlK1Jdnalg"
                      "UCD6VugMZKRhSyzWEWA9W2fg"
                      "UClOGLGPOqlAiLmOvXW5lKbw"
                      "UCnHEz9DZ6EAof1-DaQGD_Xw"
                      "UCq-xCE4xUr7RpvzjyVmYxqA"
                    ];
                  }
                  {
                    type = "twitch-channels";
                    style = "horizontal-cards";
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
                    ];
                  }
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
                    location = "Sunshine Coast, Australia";
                  }
                  {
                    type = "bookmarks";
                    groups = [
                      {
                        links = [
                          {
                            title = "NixOS Package Search";
                            url = "https://search.nixos.org/";
                          }
                          {
                            title = "Cloudflare";
                            url = "https://dash.cloudflare.com";
                          }
                          {
                            title = "QUT";
                            url = "https://qutvirtual4.qut.edu.au";
                          }
                        ];
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
                size = "full";
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
                ];
              }
              {
                size = "small";
                widgets = [
                  {
                    type = "server-stats";
                    servers = [
                      {
                        type = "local";
                        cpu-temp-sensor = true;
                        name = "Services";
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
                    type = "rss";
                    style = "vertical-list";
                    limit = 1;
                    feeds = [
                      {
                        url = "https://gitlab.futo.org/videostreaming/Grayjay.Desktop/-/tags?format=atom";
                        title = "Grayjay Releases";
                      }
                    ];
                  }
                  {
                    type = "repository";
                    repository = "poperigby/barnacle";
                  }
                  {
                    type = "repository";
                    repository = "kruziikrel13/NixOS";
                    pull-requests-limit = 0;
                    issues-limit = 3;
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
