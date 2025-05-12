{paths, pkgs, inputs, ...}: {
  imports = paths.scanPaths ./.;

  home.packages = with pkgs; [
    walker pulsemixer protonmail-desktop via tomato-c inputs.zen-browser.packages.${pkgs.system}.default
    limo heroic nixos-icons obsidian spotify 
  ];

  services.playerctld.enable = true;
  services.udiskie.enable = true;
  programs = {
    nix-init.enable = true;
    ghostty = {
      enable = true;
      enableBashIntegration = true;
      installBatSyntax = true;
      installVimSyntax = true;
      settings = {
        theme = "GitHub Dark";
        title = "Ghostty";
      };
    };
    vesktop = {
      enable = true;
      vencord.useSystem = true;
    };
  };
}
