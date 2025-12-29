#!/run/current-system/sw/bin/bash
set -euo pipefail

MODE="${1:-video}" # video | gif
OUTDIR="$HOME/Videos"
TS="$(date +'%Y-%m-%d_%H-%M-%S')"
TMP="$OUTDIR/.recording_tmp.mp4"

mkdir -p "$OUTDIR"

# Detect focused monitor and scale
MON_INFO="$(hyprctl monitors -j | jq -r '.[] | select(.focused)')"
MON_NAME="$(jq -r '.name' <<<"$MON_INFO")"

restore_scale() {
  hyprctl keyword monitor "$MON_NAME,preferred,auto,1.5" >/dev/null
}

if pgrep -x wf-recorder >/dev/null; then
  notify-send "wf-recorder" "Recording stopped"
  pkill -INT wf-recorder
  wait || true

  if [[ "$MODE" == "gif" && -f "$TMP" ]]; then
    GIF="$OUTDIR/recording-$TS.gif"
    notify-send "wf-recorder" "Converting to GIF…"

    ffmpeg -y -i "$TMP" \
      -vf "fps=12,scale=1280:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" \
      "$GIF"

    wl-copy --type image/gif <"$GIF"
    printf 'file://%s\n' "$GIF" | wl-copy --type text/uri-list

    rm -f "$TMP"
    notify-send "wf-recorder" "GIF copied to clipboard"
  fi
  restore_scale
else
  notify-send "wf-recorder" "Recording started (scale → 1)"

  # Force scale to 1
  hyprctl keyword monitor "$MON_NAME,preferred,auto,1" >/dev/null
  sleep 0.25 # allow compositor to settle

  OUTFILE="$(
    [[ "$MODE" == "gif" ]] && echo "$TMP" ||
      echo "$OUTDIR/recording-$TS.mp4"
  )"

  wf-recorder -g "$(slurp)" -f "$OUTFILE"
fi
