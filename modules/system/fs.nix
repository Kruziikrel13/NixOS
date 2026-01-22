{
  lib,
  lib',
  config,
  ...
}:
let
  inherit (lib)
    any
    attrValues
    mkDefault
    optionals
    ;
  inherit (lib.modules) mkIf;
  inherit (lib'.options) mkBoolOpt;
  cfg = config.modules.system.fs;
  fsValues = attrValues config.fileSystems;
in
{
  options.modules.system.fs = {
    enable = mkBoolOpt true;
    btrfs.enable = mkBoolOpt (any (x: x ? fsType && x.fsType == "btrfs") fsValues);
    f2fs.enable = mkBoolOpt (any (x: x ? fsType && x.fsType == "f2fs") fsValues);
  };
  config = mkIf config.modules.system.fs.enable {
    # Add f2fs to kernel modules if any fileSystem has it
    boot.kernelModules = mkIf cfg.f2fs.enable [ "f2fs" ];
    services.udisks2.enable = true;

    fileSystems = {
      # Default attributes for filesystems
      "/" = {
        device = mkDefault "/dev/disk/by-label/NIXOS";
        options = [
          "defaults"
          "noatime"
        ]
        ++ optionals cfg.btrfs.enable [
          "discard"
          "compress=zstd"
        ];

      };
      "/home".options = [
        "defaults"
        "noatime"
      ]
      ++ optionals cfg.btrfs.enable [
        "discard"
        "compress=zstd"
      ];
    };
  };
}
