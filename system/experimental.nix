{ chaotic, pkgs, ... }:
{
  imports = [ chaotic.nixosModules.default ];

  system.nixos.tags = [ "cachyos" ];
  chaotic.mesa-git.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_cachyos;

  programs.gamescope.package = pkgs.gamescope_git;

  programs = {
    steam.extraCompatPackages = [
      pkgs.proton-ge-custom
      pkgs.proton-cachyos
      pkgs.luxtorpeda
    ];
  };
  security.sudo-rs.enable = true;
  services = {
    scx = {
      enable = true;
      package = pkgs.scx.full;
      scheduler = "scx_lavd";
      extraArgs = [ "--performance" ];
    };
    dbus.implementation = "broker";
    ananicy = {
      enable = true;
      package = pkgs.ananicy-cpp;
      rulesProvider = pkgs.ananicy-rules-cachyos_git.overrideAttrs (prevAttrs: {
        patches = [
          (pkgs.fetchpatch {
            # Revert removal of compiler rules
            url = "https://github.com/CachyOS/ananicy-rules/commit/5459ed81c0e006547b4f3a3bc40c00d31ad50aa9.patch";
            revert = true;
            hash = "sha256-vc6FDwsAA6p5S6fR1FSdIRC1kCx3wGoeNarG8uEY2xM=";
          })
        ];
      });
    };
  };
}
