{
  pkgs ? import <nixpkgs> { },
}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    nil
    nixd
    statix
    nixfmt
  ];
}
