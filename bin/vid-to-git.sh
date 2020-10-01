#!/usr/bin/env nix-shell
#! nix-shell -i bash -p ffmpeg imagemagick

set -euxo pipefail

src="${1:?Missing src file}"
dst="${2:?Missing dst location}"

ffmpeg -i "$src" -r 10 -f image2pipe -vcodec ppm -vf "fps=10,scale=640:-1" - \
    | convert -delay 10 -loop 0 -layers Optimize - "$dst"
