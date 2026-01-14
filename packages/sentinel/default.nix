{
  lib,
  neovim,
  extraPackages ? [ ],
}:
neovim.overrideAttrs (oldAttrs: {
  makeWrapperArgs = (oldAttrs.makeWrapperArgs or [ ]) ++ [
    "--suffix"
    "PATH"
    ":"
    (lib.makeBinPath extraPackages)
  ];
})
