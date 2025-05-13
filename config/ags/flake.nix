{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.ags.url = "github:aylur/ags/v3";

  outputs = { self, nixpkgs, ags }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    packages.${system}.default = pkgs.stdenv.mkDerivation { # [!code focus:29]
      pname = "ags_shell";
      version = "0.1";
      src = ./.;

      nativeBuildInputs = with pkgs; [
        wrapGAppsHook
        gobject-introspection
        ags.packages.${system}.default
      ];

      buildInputs = [
        pkgs.glib
        pkgs.gjs
        ags.packages.${system}.io
        ags.packages.${system}.hyprland
        ags.packages.${system}.tray
      ];

      installPhase = ''
        ags bundle app.ts $out/bin/ags-shell
        '';

      preFixup = ''
        gappsWrapperArgs+=(
        --prefix PATH: ${pkgs.lib.makeBinPath [
          ags.packages.${system}.default
        ]}
        )
        '';

    };
  };
}
