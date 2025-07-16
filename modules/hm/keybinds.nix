{ config, lib, pkgs, ... }:

{
  home.file.".local/lib/hyde/toggle-hdmi.sh" = {
    executable = true;
    source = ../../resources/scripts/toggle-hdmi.sh;
  };
  # Override the keybindings.conf that Hydenix manages
  home.file.".config/hypr/keybindings.conf" = lib.mkForce {
    text = ''
      ## █▄▀ █▀▀ █▄█ █▄▄ █ █▄░█ █▀▄ █ █▄░█ █▀▀ █▀
      ## █░█ ██▄ ░█░ █▄█ █ █░▀█ █▄▀ █ █░▀█ █▄█ ▄█
      # Vim-Inspired Hyprland Keybindings

      #*  Variables
      # Default if commented out
      # $mainMod = Super # super / meta / windows key
      # Assign apps
      # $TERMINAL = kitty
      # $EDITOR = code
      # $EXPLORER = dolphin
      # $BROWSER = firefox

      $wm=Window Management
      $d=[$wm|Basic Controls]
      bindd = $mainMod, q, $d close window , exec, $scrPath/dontkillsteam.sh
      bindd = Alt, F4, $d close window, exec, $scrPath/dontkillsteam.sh
      bindd = $mainMod Shift Control, q, $d quit hyprland , exit
      bindd = $mainMod Shift, space, $d toggle float, togglefloating
      bindd = $mainMod, g, $d toggle group, togglegroup
      bindd = $mainMod, f, $d fullscreen (like vim fullscreen), fullscreen
      bindd = $mainMod, x, $d lock screen, exec, lockscreen.sh
      bindd = $mainMod Shift, p, $d pin window, exec, $scrPath/windowpin.sh
      bindd = Control Alt, Delete, $d logout menu, exec, $scrPath/logoutlaunch.sh

      $d=[$wm|Group Navigation]
      bindd = $mainMod, bracketleft, $d previous group [ ], changegroupactive, b
      bindd = $mainMod, bracketright, $d next group [ ], changegroupactive, f

      $d=[$wm|Focus Navigation]
      bindd = $mainMod, h, $d ← focus left, movefocus, l
      bindd = $mainMod, l, $d → focus right, movefocus, r
      bindd = $mainMod, k, $d ↑ focus up, movefocus, u
      bindd = $mainMod, j, $d ↓ focus down, movefocus, d
      # Arrow keys as backup
      bindd = $mainMod, Left, $d ← focus left (arrow), movefocus, l
      bindd = $mainMod, Right, $d → focus right (arrow), movefocus, r
      bindd = $mainMod, Up, $d ↑ focus up (arrow), movefocus, u
      bindd = $mainMod, Down, $d ↓ focus down (arrow), movefocus, d

      $d=[$wm|Window Resize|Vim Style]
      bindde = $mainMod Shift, l, $d ⤡ resize right (Shift+L), resizeactive, 30 0
      bindde = $mainMod Shift, h, $d ⤢ resize left (Shift+H), resizeactive, -30 0
      bindde = $mainMod Shift, k, $d ⤴ resize up (Shift+K), resizeactive, 0 -30
      bindde = $mainMod Shift, j, $d ⤵ resize down (Shift+J), resizeactive, 0 30

      $d=[$wm|Window Movement|Vim Style]
      $moveactivewindow=grep -q "true" <<< $(hyprctl activewindow -j | jq -r .floating) && hyprctl dispatch moveactive
      bindde = $mainMod Control, h, $d ⬅ move left (Ctrl+H), exec, $moveactivewindow -30 0 || hyprctl dispatch movewindow l
      bindde = $mainMod Control, l, $d ➡ move right (Ctrl+L), exec, $moveactivewindow 30 0 || hyprctl dispatch movewindow r
      bindde = $mainMod Control, k, $d ⬆ move up (Ctrl+K), exec, $moveactivewindow 0 -30 || hyprctl dispatch movewindow u
      bindde = $mainMod Control, j, $d ⬇ move down (Ctrl+J), exec, $moveactivewindow 0 30 || hyprctl dispatch movewindow d

      # Move/Resize focused window
      $d=[$wm|Move & Resize with mouse]
      binddm = $mainMod, mouse:272, $d hold to move window, movewindow
      binddm = $mainMod, mouse:273, $d hold to resize window, resizewindow
      binddm = $mainMod, z, $d hold to move window, movewindow
      binddm = $mainMod Shift, z, $d hold to resize window, resizewindow

      # Toggle focused window split (like vim :sp/:vsp)
      $d=[$wm]
      bindd = $mainMod, s, $d toggle split, togglesplit

      $l=Launcher
      $d=[$l|Apps - Vim mnemonic style]
      bindd = $mainMod, Return, $d terminal emulator, exec, $TERMINAL
      bindd = $mainMod, e, $d file explorer, exec, $EXPLORER
      bindd = $mainMod, v, $d text editor, exec, $EDITOR
      bindd = $mainMod, b, $d web browser, exec, $BROWSER
      bindd = Control Shift, Escape, $d system monitor, exec, $scrPath/sysmonlaunch.sh

      $d=[$l|Rofi menus - Vim leader style]
      $rofi-launch=$scrPath/rofilaunch.sh
      bindd = $mainMod, space, $d application finder, exec, pkill -x rofi || $rofi-launch d
      bindd = $mainMod , Tab, $d window switcher, exec, pkill -x rofi || $rofi-launch w
      bindd = $mainMod Shift, e, $d file finder, exec, pkill -x rofi || $rofi-launch f
      bindd = $mainMod, slash, $d keybindings hint, exec, pkill -x rofi || $scrPath/keybinds_hint.sh c
      bindd = $mainMod, semicolon, $d emoji picker, exec, pkill -x rofi || $scrPath/emoji-picker.sh
      bindd = $mainMod, apostrophe, $d glyph picker, exec, pkill -x rofi || $scrPath/glyph-picker.sh
      bindd = $mainMod, p, $d clipboard, exec, pkill -x rofi || $scrPath/cliphist.sh -c
      bindd = $mainMod Shift, p, $d clipboard manager, exec, pkill -x rofi || $scrPath/cliphist.sh
      #bindd = $mainMod, m, $d select rofi launcher, exec, pkill -x rofi || $scrPath/rofiselect.sh

      $hc=Hardware Controls
      $d=[$hc|Audio]
      binddl = , F10, $d toggle mute output, exec, $scrPath/volumecontrol.sh -o m
      binddl = , XF86AudioMute, $d toggle mute output, exec, $scrPath/volumecontrol.sh -o m
      binddel = , F11, $d decrease volume, exec, $scrPath/volumecontrol.sh -o d
      binddel = , F12, $d increase volume, exec, $scrPath/volumecontrol.sh -o i
      binddl = , XF86AudioMicMute, $d un/mute microphone, exec, $scrPath/volumecontrol.sh -i m
      binddel = , XF86AudioLowerVolume, $d decrease volume, exec, $scrPath/volumecontrol.sh -o d
      binddel = , XF86AudioRaiseVolume, $d increase volume, exec, $scrPath/volumecontrol.sh -o i

      $d=[$hc|Media]
      binddl = , XF86AudioPlay, $d play media, exec, playerctl play-pause
      binddl = , XF86AudioPause, $d pause media, exec, playerctl play-pause
      binddl = , XF86AudioNext, $d next media, exec, playerctl next
      binddl = , XF86AudioPrev, $d previous media, exec, playerctl previous

      $d=[$hc|Brightness]
      binddel = , XF86MonBrightnessUp, $d increase brightness, exec, $scrPath/brightnesscontrol.sh i
      binddel = , XF86MonBrightnessDown, $d decrease brightness, exec, $scrPath/brightnesscontrol.sh d

      $ut=Utilities
      $d=[$ut]
      binddl = $mainMod, backslash, $d toggle keyboard layout, exec, $scrPath/keyboardswitch.sh
      bindd = $mainMod, F11, $d game mode, exec, $scrPath/gamemode.sh

      $d=[$ut|Screen Capture]
      bindd = $mainMod Shift, c, $d color picker, exec, hyprpicker -an
      bindd = $mainMod Shift, s, $d snip screen, exec, $scrPath/screenshot.sh s
      bindd = $mainMod Control Shift, s, $d freeze and snip screen, exec, $scrPath/screenshot.sh sf
      binddl = $mainMod Shift, m, $d print monitor, exec, $scrPath/screenshot.sh m
      binddl = , Print, $d print all monitors, exec, $scrPath/screenshot.sh p

      $rice=Theming and Wallpaper
      $d=[$rice|Vim-style navigation]
      bindd = $mainMod, period, $d next global wallpaper, exec, $scrPath/wallpaper.sh -Gn
      bindd = $mainMod, comma, $d previous global wallpaper, exec, $scrPath/wallpaper.sh -Gp
      bindd = $mainMod, w, $d select a global wallpaper, exec, pkill -x rofi || $scrPath/wallpaper.sh -SG
      bindd = $mainMod Control, period, $d next waybar layout, exec, $scrPath/wbarconfgen.sh n
      bindd = $mainMod Control, comma, $d previous waybar layout, exec, $scrPath/wbarconfgen.sh p
      bindd = $mainMod, r, $d wallbash mode selector, exec, pkill -x rofi || $scrPath/wallbashtoggle.sh -m
      bindd = $mainMod, t, $d select a theme, exec, pkill -x rofi || $scrPath/themeselect.sh

      $ws=Workspaces
      $d=[$ws|Navigation - Numbers like Vim]
      bindd = $mainMod, 1, $d navigate to workspace 1, workspace, 1
      bindd = $mainMod, 2, $d navigate to workspace 2, workspace, 2
      bindd = $mainMod, 3, $d navigate to workspace 3, workspace, 3
      bindd = $mainMod, 4, $d navigate to workspace 4, workspace, 4
      bindd = $mainMod, 5, $d navigate to workspace 5, workspace, 5
      bindd = $mainMod, 6, $d navigate to workspace 6, workspace, 6
      bindd = $mainMod, 7, $d navigate to workspace 7, workspace, 7
      bindd = $mainMod, 8, $d navigate to workspace 8, workspace, 8
      bindd = $mainMod, 9, $d navigate to workspace 9, workspace, 9
      bindd = $mainMod, 0, $d navigate to workspace 10, workspace, 10

      $d=[$ws|Navigation|Relative workspace - Vim style]
      bindd = $mainMod , Grave, $d change to last active workspace forwards, workspace, previous_per_monitor
      bindd = $mainMod Control, l, $d change active workspace forwards, workspace, r+1
      bindd = $mainMod Control, h, $d change active workspace backwards, workspace, r-1

      $d=[$ws|Navigation]
      bindd = $mainMod, n, $d navigate to the nearest empty workspace, workspace, empty

      # Move focused window to a workspace (Shift + number like Vim)
      $d=[$ws|Move window to workspace]
      bindd = $mainMod Shift, 1, $d move to workspace 1, movetoworkspace, 1
      bindd = $mainMod Shift, 2, $d move to workspace 2, movetoworkspace, 2
      bindd = $mainMod Shift, 3, $d move to workspace 3, movetoworkspace, 3
      bindd = $mainMod Shift, 4, $d move to workspace 4, movetoworkspace, 4
      bindd = $mainMod Shift, 5, $d move to workspace 5, movetoworkspace, 5
      bindd = $mainMod Shift, 6, $d move to workspace 6, movetoworkspace, 6
      bindd = $mainMod Shift, 7, $d move to workspace 7, movetoworkspace, 7
      bindd = $mainMod Shift, 8, $d move to workspace 8, movetoworkspace, 8
      bindd = $mainMod Shift, 9, $d move to workspace 9, movetoworkspace, 9
      bindd = $mainMod Shift, 0, $d move to workspace 10, movetoworkspace, 10

      # Move focused window to a relative workspace
      $d=[$ws|Move to relative workspace - Vim style]
      bindd = $mainMod Control Shift, l, $d move window to next relative workspace, movetoworkspace, r+1
      bindd = $mainMod Control Shift, h, $d move window to previous relative workspace, movetoworkspace, r-1

      # Scroll through existing workspaces
      $d=[$ws|Navigation]
      bindd = $mainMod, mouse_down, $d next workspace, workspace, e+1
      bindd = $mainMod, mouse_up, $d previous workspace, workspace, e-1

      # Move/Switch to special workspace (scratchpad) - like Vim's scratch buffer
      $d=[$ws|Navigation|Special workspace]
      bindd = $mainMod, minus, $d move to scratchpad, movetoworkspace, special
      bindd = $mainMod Shift, minus, $d move to scratchpad (silent), movetoworkspacesilent, special
      bindd = $mainMod, equal, $d toggle scratchpad, togglespecialworkspace

      # Move focused window to a workspace silently (like Vim's :silent)
      $d=[$ws|Navigation|Move window silently]
      bindd = $mainMod Alt, 1, $d move to workspace 1 (silent), movetoworkspacesilent, 1
      bindd = $mainMod Alt, 2, $d move to workspace 2 (silent), movetoworkspacesilent, 2
      bindd = $mainMod Alt, 3, $d move to workspace 3 (silent), movetoworkspacesilent, 3
      bindd = $mainMod Alt, 4, $d move to workspace 4 (silent), movetoworkspacesilent, 4
      bindd = $mainMod Alt, 5, $d move to workspace 5 (silent), movetoworkspacesilent, 5
      bindd = $mainMod Alt, 6, $d move to workspace 6 (silent), movetoworkspacesilent, 6
      bindd = $mainMod Alt, 7, $d move to workspace 7 (silent), movetoworkspacesilent, 7
      bindd = $mainMod Alt, 8, $d move to workspace 8 (silent), movetoworkspacesilent, 8
      bindd = $mainMod Alt, 9, $d move to workspace 9 (silent), movetoworkspacesilent, 9
      bindd = $mainMod Alt, 0, $d move to workspace 10 (silent), movetoworkspacesilent, 10

      # FCITX stuff
      $d=[$wm|Input Method]
      bindd = Control, space, $d toggle input method, exec, fcitx5-remote -t
      bindd = $mainMod Shift, I, $d fcitx5 config tool, exec, fcitx5-configtool

      # Custom Scripts
      $d=[$wm|Custom Scripts]
      bindd = $mainMod , m, $d toggle hdmi left and right, exec, $scrPath/toggle-hdmi.sh
      #bindd = $mainMod, m, $d select rofi launcher, exec, pkill -x rofi || $scrPath/rofiselect.sh


      $d=#! unset the group name
    '';
  };
}
