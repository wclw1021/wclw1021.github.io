#!/bin/bash
set -euo pipefail

if [ "$#" -lt 2 ] || [ "$#" -gt 4 ]; then
  echo "Usage: $0 INPUT_VIDEO OUTPUT_GIF [START_SECONDS] [DURATION_SECONDS]" >&2
  exit 1
fi

input=$1
output=$2
start=${3:-0}
duration=${4:-}

trim_args=(-ss "$start")
if [ -n "$duration" ]; then
  trim_args+=(-t "$duration")
fi

mkdir -p "$(dirname "$output")"

ffmpeg -y "${trim_args[@]}" -i "$input" \
  -filter_complex "[0:v]fps=12,scale=350:-1:flags=lanczos,split[s0][s1];[s0]palettegen=max_colors=128:stats_mode=diff[p];[s1][p]paletteuse=dither=bayer:bayer_scale=3:diff_mode=rectangle[v]" \
  -map "[v]" -loop 0 "$output"
