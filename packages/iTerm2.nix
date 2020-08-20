{ stdenv, fetchurl, undmg, unzip }:

stdenv.mkDerivation rec {
  pname = "iTerm2";
  appname = "iTerm";
  version = "3.3.12";

  buildInputs = [ undmg unzip ];
  sourceRoot = "iTerm.app";
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
      mkdir -p "$out/Applications/${appname}.app"
      cp -pR * "$out/Applications/${appname}.app"
    '';

  src = fetchurl {
    url = "https://iterm2.com/downloads/stable/iTerm2-3_3_12.zip";
    sha256 = "6811b520699e8331b5d80b5da1e370e0ed467e68bc56906f08ecfa986e318167";
  };

  meta = with stdenv.lib; {
    description = "iTerm2 is a replacement for Terminal and the successor to iTerm";
    homepage = "https://www.iterm2.com";
    maintainers = [ maintainers.griffithsjr ];
    platforms = platforms.darwin;
  };
}
