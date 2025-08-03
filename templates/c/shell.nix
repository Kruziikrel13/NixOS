with import <nixpkgs> {};
  pkgs.mkShell {
    name = "C Development Shell";
    nativeBuildInputs = with pkgs; [gcc cmake clang-tools];
  }
