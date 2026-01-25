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
                    type = "to-do";
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
                  {
                    type = "hacker-news";
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
                  {
                    type = "bookmarks";
                    groups = [
                      {
                        links = [
                          {
                            title = "GitHub";
                            url = "https://github.com/";
                          }
                          {
                            title = "NixOS Package Search";
                            url = "https://search.nixos.org/";
                          }
                          {
                            title = "Grayjay Desktop";
                            url = "https://gitlab.futo.org/videostreaming/Grayjay.Desktop";
                          }
                        ];
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

# {
#                 size = "small";
#                 widgets = [
#                   {
#                     type = "calendar";
#                   }
#                 ];
#               }
#               {
#                 size = "full";
#                 widgets = [
#
#                 ];
#               }
# {
#             name = "Home";
#             columns = [
#               {
#                 size = "small";
#                 widgets = [
#
# {
#                     type = "server-stats";
#                     servers = [
#                       {
#                         name = "Local Services";
#                         type = "local";
#                         cpu-temp-sensor = true;
#                       }
#                     ];
#                   }
#                 ];
#               }
#               {
#                 size = "full";
#                 widgets = [
#                   {
#                     type = "videos";
#                     style = "grid-cards";
#                     channels = [
#                       "UC2MjZanWOfyfsrHOyitmXbQ"
#                       "UCNqHkzC_AlCPMwjTOSblkaA"
#                       "UC-9b7aDP6ZN0coj9-xFnrtw"
#                       "UCyMnHssVup_wBZRnCSMVt3w"
#                     ];
#                   }
#                 ];
#               }
#               {
#                 size = "small";
#                 widgets = [
#                   {
#                     type = "to-do";
#                     size = "vertical-list";
#                   }
#                   {
#                     type = "repository";
#                     repository = "poperigby/barnacle";
#                     pull-requests-limit = 1;
#                     issues-limit = 3;
#                     commits-limit = 3;
#                   }
#                   {
#                     type = "repository";
#                     repository = "kruziikrel13/NixOS";
#                     pull-requests-limit = 0;
#                     issues-limit = 1;
#                     commits-limit = 3;
#                   }
#                 ];
#               }
#             ];
#           }
#           {
#             name = "RSS";
#             columns = [
#               {
#                 size = "full";
#                 widgets = [
#                   {
#                     title = "News";
#                     type = "rss";
#                     style = "detailed-list";
#                     feeds = [
#                       {
#                         url = "https://openrss.org/feed/github.com/hyprwm/Hyprland/releases";
#                         title = "Hyprland Releases";
#                       }
#                       {
#                         url = "https://gitlab.futo.org/videostreaming/Grayjay.Desktop/-/tags?format=atom";
#                         title = "Grayjay Releases";
#                       }
#                     ];
#                   }
#                 ];
#               }
#             ];
#           }
