{
  mkShellNoCC,
  lib,
  bash,
  nil,
  nixd,
  statix,
  nixfmt,
  ...
}:
mkShellNoCC {
  shellHook = ''
    export SHELL=${lib.getExe bash}
  '';

  packages = [
    nil
    nixd
    statix
    nixfmt
  ];
}
