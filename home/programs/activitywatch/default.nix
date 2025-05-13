{paths, pkgs, ...}: {
  imports = paths.scanPaths ./.;
  services.activitywatch = {
    package = pkgs.aw-server-rust;
    settings = {
      host = "127.0.0.1";
      port = 5600;
    };
    watchers.aw-watcher = {
      package = pkgs.awatcher;
      executable = "awatcher";
      settings = {
        timeout = 180;
        poll_time = 2;
      };
    };
  };
}
