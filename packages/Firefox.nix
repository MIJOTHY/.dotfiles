{ stdenv, lib, fetchurl, undmg }:

stdenv.mkDerivation rec {
  pname = "Firefox";
  version = "79.0";

  buildInputs = [ undmg ];
  sourceRoot = ".";
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
      mkdir -p "$out/Applications"
      cp -r ${pname}.app "$out/Applications/${pname}.app"
    '';

  src = fetchurl {
    name = "${pname}-${version}.dmg";
    url = "https://download-installer.cdn.mozilla.net/pub/firefox/releases/${version}/mac/en-GB/Firefox%20${version}.dmg";
    sha256 = "2c30907955df849944559b0cd569bcacdaaaa27500ec5d63dcd691d6847b4430";
  };

  meta = with lib; {
    description = "The Firefox web browser";
    homepage = "https://www.mozilla.org/en-GB/firefox";
    maintainers = [ maintainers.griffithsjr ];
    platforms = platforms.darwin;
  };
}
