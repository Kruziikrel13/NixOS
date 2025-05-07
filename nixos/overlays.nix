{ inputs, ... }: {
  nixpkgs.overlays = [
    inputs.neovim-nightly.overlays.default
    (self: super: {
      limo = super.limo.overrideAttrs {
        version = "1.2.2";
        src = super.fetchFromGitHub {
          owner = "limo-app";
          repo = "limo";
          tag = "v${self.limo.version}";
          hash = "sha256-ZnGDEoZLKlbtAzPKg5dIisvV1pR+Usu6m71zRQBa9ig=";
        };
      };
    })
  ];
}
