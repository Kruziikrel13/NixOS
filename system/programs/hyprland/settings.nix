{...}: {
  programs.hyprland.settings = {
    exec-once = [
      "uwsm finalize"
      "hyprctl setcursor Bibata-Modern-Classic-Hyprcursor ${toString 16}"
    ];
  };
}
