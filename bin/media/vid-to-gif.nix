{ pkgs, stdenv, binCommon, ... }:

stdenv.writeShellScriptBin "vid-to-gif" ''
  ${binCommon.strictMode}

  main() {
    src="''${1:?Missing src file}"
    dst="''${2:?Missing dst location}"

    ffmpeg=${pkgs.ffmpeg}/bin/ffmpeg
    convert=${pkgs.imagemagick}/bin/convert

    ffmpeg -i "$src" \
      -r 10 \
      -f image2pipe \
      -vcodec ppm \
      -vf "fps=10,scale=640:-1" - \
      | convert -delay 10 -loop 0 -layers Optimize - "$dst"
  }

  main "$@"
''
