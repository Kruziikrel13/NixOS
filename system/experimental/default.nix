{customLib, globals, ... }: 
if !globals.experimental.enable then {}
else {
  imports = customLib.scanPaths ./.;
}
