{
  config,
  pkgs,
  lib,
  ...
}:
let
  ac-status-watcher = pkgs.writeShellScriptBin "ac-status-watcher" ''
    #!/usr/bin/env bash
    set -euo pipefail

    SYS_POWER="/sys/class/power_supply"
    AC_TYPE_FILE=$(grep -l "Mains" $SYS_POWER/*/type 2>/dev/null | head -n 1)
    BAT_TYPE_FILE="$(grep -l "Battery" "$SYS_POWER"/*/type 2>/dev/null | head -n 1 || true)"

    if [ -z "$AC_TYPE_FILE" || -z "$BAT_TYPE_FILE" ]; then
      exit 1
    fi 

    AC_DIR=$(dirname "$AC_TYPE_FILE")
    BAT_DIR="$(dirname "$BAT_TYPE_FILE")"

    get_battery_level() {
      if [ -r "$BAT_DIR/capacity" ]; then
        cat "$BAT_DIR/capacity"
      else
        echo "?"
      fi
    }

    LAST_STATE=$(cat "$AC_DIR/online")

    udevadm monitor --subsystem-match=power_supply | while read -r line; do
      sleep 0.5
      CURRENT_STATE=$(cat "$AC_DIR/online")
      BAT_LEVEL="$(get_battery_level)"
    
      if [ "$CURRENT_STATE" != "$LAST_STATE" ]; then
          if [ "$CURRENT_STATE" = "1" ]; then
              notify-send "AC Connected" "Battery : ''${BAT_LEVEL}%"
          else
              notify-send "AC Disconnected" "Battery : ''${BAT_LEVEL}%"
          fi
          LAST_STATE=$CURRENT_STATE
      fi
    done
  ''; 

in
lib.mkIf config.me.host.isLaptop {

  systemd.user.services.ac-status-watcher = {
    description = "Send a notification on AC status change";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    path = with pkgs; [
      libnotify
      systemd
      coreutils
      gnugrep  
    ];
    serviceConfig = {
      ExecStart = "${ac-status-watcher}/bin/ac-status-watcher";
      Type = "exec";
      Restart = "always";
      RestartSec = "5";
    };
  };

}