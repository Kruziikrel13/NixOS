{
  description = "Basic developer shell flake";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  outputs = { nixpkgs }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [ ];
      env = { };
      shellHook = ''

      '';
    };
  };
}
