{
home-manager,
globals,
customLib,
pkgs,
inputs,
...
}: {
  imports = [ home-manager.nixosModules.home-manager ];
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.${globals.user.name} = { config, customLib, ... }: {
    news.display = "show";
    home.username = globals.user.name;
    home.homeDirectory = "/home/${config.home.username}";
    home.preferXdgDirectories = true;
    home.stateVersion = "24.11";
    imports = [ inputs.ags.homeManagerModules.default ./hyprland ./nvim.nix ./programs.nix ./shell.nix ];
    programs.ags = {
      enable = true;
      configDir = null;
      extraPackages = with pkgs; [
        inputs.ags.packages.${pkgs.system}.battery
        inputs.ags.packages.${pkgs.system}.hyprland
        inputs.ags.packages.${pkgs.system}.apps
        inputs.ags.packages.${pkgs.system}.wireplumber
        inputs.ags.packages.${pkgs.system}.notifd
        inputs.ags.packages.${pkgs.system}.tray
      ];
    };
  };
}
