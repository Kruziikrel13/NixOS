{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  nativeBuildInputs = [ pkgs.nixd pkgs.nil ];
}
