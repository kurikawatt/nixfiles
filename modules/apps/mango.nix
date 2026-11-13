{
  config,
  lib,
  ...
}:
let
  inherit (config.me) colors fonts;
  inherit (config.networking) hostName;
in
lib.mkIf (config.me.host.isDesktop) {

  programs.mango = {
    
    enable = true;
    
    autostart_sh = ''
      foot --server & 
      noctalia
    '';

    settings = {
      # Mess
      sync_obj_enable = 1; # if osConfig.me.host.gpuType == "nvidia" then 1 else 0
      
      # Keyboard
      xkb_rules_layout = "fr";
      numlock_on = 1;
      
      # Navigation
      trackpad_natural_scrolling = 1;
      mouse_natural_scrolling = 0;
      
      # Layout
      circle_layout = "monocle,tile";
      tag_rule = builtins.genList (i: "id:${toString (i + 1)},layout_name:monocle") 9;

      # Theming
      border_px = 0;
      gap_outer = {
        horizontal = 0;
        vertical = 0;
      };

      # Monocle
      tab_bar_height = 0;

      # Jump
      jump_label_decorate = {
        fg_color = "0x${colors.foreground}ff";
        bg_color = "0x${colors.background}ff";
        focus = {
          fg_color = "0x${colors.foreground}ff";
          bg_color = "0x${colors.background}ff";
        };
        border = {
          color = "0xec4067ff";
          width = 4;
        };
        corner_radius = 5;
        padding = {
          x = 10;
          y = 10;
        };
        font_desc = "${fonts.name} 24";
      };

      # Bindings
      bind = [
        # reload
        "super+shift, r, reload_config"
        # lock
        "super, l, spawn, noctalia msg session lock"
        # kill client
        "super, c, killclient"
        # open jump
        "alt, tab, togglejump"
        # workspace navigation
        "super, left, viewtoleft"
        "super, right, viewtoright"
        # switch layout
        "super+shift, tab, switch_layout"
        # monocle change focused window
        "super, tab, focusstack, next"
        # Move window to other tag/workspace
        "super+ctrl, left, tagtoleft"
        "super+ctrl, right, tagtoright"
        # Move window to other monitors
        "super+shift, left, tagmon, left"
        "super+shift, right, tagmon, right"
        # 
      ]
      # Apps
      ++ [
        "super, t, spawn, footclient"
        "super, r, spawn, noctalia msg panel-toggle launcher"
        "super, z, spawn, zen"
        "super, e, spawn, footclient -e 'yazi'"
      ]
      # Volume, Player & Brightness control
      ++ [
        "none, XF86AudioRaiseVolume, spawn, noctalia msg volume-up"
        "none, XF86AudioLowerVolume, spawn, noctalia msg volume-down"
        "none, XF86AudioMute, spawn, noctalia msg volume-mute"
        "none, XF86MonBrightnessUp, spawn, noctalia msg brightness-up"
        "none, XF86MonBrightnessDown, spawn, noctalia msg brightness-down"
        "none, XF86AudioPlay, spawn, playerctl play-pause"
      ]
      ++ builtins.genList (i: "super, ${toString (i + 1)}, view, ${toString (i + 1)}") 9;
      gesturebind = [
        "none, left, 3, viewtoright"
        "none, right, 3, viewtoleft"
      ];

      monitor_rule =
        if (hostName == "queen") then [
          "model:PL2770H, serial:1244742501074, width:1920, height:1080, refresh:180, x:1920, y:0"
          "model:PL2770H, serial:1244742500978, width:1920, height:1080, refresh:180, x:3840, y:0"
          "model:PL2730H, serial:1153690703375, width:1920, height:1080, refresh:75, x:0, y:0"
        ] else if (hostName == "aigis") then [
          "model:0x0928, width:1920, height:1080, refresh:60, x:0, y:0"
        ] else if (hostName == "euphausia") then [
          "model:0x0BC9, width:2560, height:1600, refresh:165, x:0, y:0, scale:1.5"
        ] else [];
    };

  };

}