{
  mkShellNoCC,
  git,
  nil,
  nixd,
  statix,
  nixfmt,
  ...
}:
let
  nixConfig = builtins.toFile "nix.conf" ''
    warn-dirty = false
    http2 = true
    experimental-features = nix-command flakes
    use-xdg-base-directories = true
  '';
in
mkShellNoCC {
  packages = [
    git
    nil
    nixd
    statix
    nixfmt
  ];

  shellHook = ''
    export NIX_USER_CONF_FILES="${nixConfig}"
  '';
}
