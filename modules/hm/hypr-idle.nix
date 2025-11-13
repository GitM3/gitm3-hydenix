{
  config,
  lib,
  pkgs,
  ...
}:
{
  # Override the userprefs.conf that Hydenix manages with fcitx5 configuration
  home.file.".config/hypr/hypridle.conf" = lib.mkForce {
    text = ''
      # ZANDER'S CONF
      $LOCKSCREEN = lockscreen.sh # Calls $LOCKSCREEN set from hyprland
      $IF_DISCHARGING = ~/hydix/resources/scripts/if_discharging.sh
      general {
        lock_cmd = $LOCKSCREEN
        unlock_cmd = notify-send "unlock!"      # same as above, but unlock
        before_sleep_cmd = $LOCKSCREEN    # command ran before sleep
        after_sleep_cmd =  notify-send "Awake!"  # command ran after sleep
        ignore_dbus_inhibit = false             # whether to ignore dbus-sent idle-inhibit requests (used by e.g. firefox or steam)
        ignore_systemd_inhibit = false          # whether to ignore systemd-inhibit --what=idle inhibitors
      }

      # Dims the display
      listener {
        timeout = 180
        on-timeout =  $IF_DISCHARGING "brightnessctl -s && brightnessctl s 30%"
        on-resume =   $IF_DISCHARGING brightnessctl -r
      }

      # Lock it first before dpms off so that screen won't show for a moment after wake up.
      listener {
        timeout = 300
        on-timeout = $IF_DISCHARGING $LOCKSCREEN
      }

      # DPMS off
      listener {
        timeout = 360
        on-timeout = $IF_DISCHARGING hyprctl dispatch dpms off #do not turn off display while media is playing
        on-resume = $IF_DISCHARGING hyprctl dispatch dpms on
      }

      # Suspend
       listener {
         timeout = 600
         on-timeout = $IF_DISCHARGING systemctl suspend
       }

      # hyprlang noerror true
      # Source anything  from this path if you want to add your own listener
      # source command actually do not exist yet
      source = ~/.config/hypridle/*
      # hyprlang noerror false

    '';
  };
}
