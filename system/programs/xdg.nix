{pkgs, ...}: {
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = ["gtk"];
    };

    extraPortal = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
