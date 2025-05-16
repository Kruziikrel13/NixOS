{pkgs, ...}: let
  idea = pkgs.jetbrains.idea-ultimate;
  pycharm = pkgs.jetbrains.pycharm-professional;
in {
  home.packages = [ idea pycharm ];
  xdg.configFile."JetBrains/IntelliJIdea${idea.version}/idea64.vmoptions".text = "-Dawt.toolkit.name=WLToolkit";
}
