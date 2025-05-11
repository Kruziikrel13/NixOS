{pkgs, ...}: let
  idea = pkgs.jetbrains-idea-ultimate;
in {
  home.packages = [ idea ];
  xdg.configFile."JetBrains/IntelliJIdea${idea.version}/idea64.vmoptions".text = "-Dawt.toolkit.name=WLToolkit";
}
