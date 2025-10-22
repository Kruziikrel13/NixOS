{
  pkgs,
  lib,
  ...
}:
let
  extra-pkgs = with pkgs; [
    dotnet-sdk_3
    dotnetCorePackages.sdk_8_0_3xx
    dotnetPackages.Nuget
    mono
    msbuild
  ];
  extra-lib = [ ];
  rider = pkgs.jetbrains.rider.overrideAttrs (attrs: {
    postInstall = (attrs.postInstall or "") + ''
      # Wrap rider with extra tools and libraries
      mv $out/bin/rider $out/bin/.rider-toolless
      makeWrapper $out/bin/.rider-toolless $out/bin/rider \
        --argv0 rider \
        --prefix PATH : "${lib.makeBinPath extra-pkgs}" \
        --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath extra-lib}"

      # Unity Rider Fix
      shopt -s extglob
      ln -s $out/rider/!(bin) $out/
      shopt -u extglob
    '';
  });
in
{
  home.packages = [
    rider
    pkgs.unityhub
  ];

  home.activation = {
    makeUnityConfigDir = ''
      run mkdir -p $HOME/.local/share/unity3d
    '';
  };

  home.file.rider = {
    target = ".local/share/applications/jetbrains-rider.desktop";
    source = "${
      pkgs.makeDesktopItem {
        name = "jetbrains-rider";
        desktopName = "Rider";
        exec = "\"${rider}/bin/rider\"";
        icon = "rider";
        type = "Application";
        extraConfig.NoDisplay = "true";
      }
    }/share/applications/jetbrains-rider.desktop";
  };
}
