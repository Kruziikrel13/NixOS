{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.opts.System;
in {
  options = {
    opts = {
      System = {
        Version = mkOption {
          type = types.str;
          default = "23.05";
        };
      };
    };
  };

  config = {
    system.stateVersion = cfg.Version;
    nix = {
      settings = {
        keep-outputs = false;
        keep-derivations = false;
        show-trace = false;
        auto-optimise-store = true;
        sandbox = true;
      };
      gc = {
        automatic = false;
        dates = "weekly";
        options = "--delete-old";
      };
      optimise = {
        automatic = true;
        dates = ["monday"];
      };
    };

    nixpkgs = {
      config.checkMeta = true;
      config.allowUnfree = false;
      config.enableParallelBuildingByDefault = false;
    };
  };
}
