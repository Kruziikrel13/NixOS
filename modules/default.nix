{ self, ... }:
{
  imports = self.lib.modules.mapModulesRec' ./. import;
}
