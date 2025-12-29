#!/run/current-system/sw/bin/bash
set -euo pipefail

MODE="${1:-video}" # video | gif
OUTDIR="$HOME/Videos"
TMP="$OUTDIR/.recording_tmp.mp4"
TS="$(date +'%Y-%m-%d_%H-%M-%S')"

mkdir -p "$OUTDIR"

if pgrep -x wf-recorder >/dev/null; then
  notify-send "wf-recorder" "Recording stopped"
  pkill -INT wf-recorder

  # Post-process to GIF if requested
  if [[ "$MODE" == "gif" && -f "$TMP" ]]; then
    GIF="$OUTDIR/recording-$TS.gif"
    notify-send "wf-recorder" "Converting to GIF…"

    ffmpeg -y -i "$TMP" \
      -vf "fps=12,scale=1280:-1:flags=lanczos" \
      "$GIF"

    wl-copy --type image/gif <"$GIF"
    printf 'file://%s\n' "$GIF" | wl-copy --type text/uri-list
    rm -f "$TMP"
    notify-send "wf-recorder" "GIF saved"
  fi

else
  notify-send "wf-recorder" "Recording started ($MODE)"

  wf-recorder -g "$(slurp)" \
    -f "$(
      [[ "$MODE" == "gif" ]] && echo "$TMP" ||
        echo "$OUTDIR/recording-$TS.mp4"
    )"
fi
