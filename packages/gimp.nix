{ stdenv, lib, fetchurl, undmg }:

stdenv.mkDerivation rec {
  pname = "gimp";
  appname = "GIMP-2.10";
  version = "2.10.14";

  buildInputs = [ undmg ];
  sourceRoot = ".";
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
      mkdir -p "$out/Applications"
      cp -r ${appname}.app "$out/Applications/${appname}.app"
    '';

  src = fetchurl {
    name = "${pname}-${version}.dmg";
    url = "https://download.gimp.org/pub/gimp/v2.10/osx/${pname}-${version}-x86_64.dmg";
    sha256 = "60631e39a1042c38cc281bc3213a76be109fb909b9671fb03c55cf5cf31ea632";
  };

  meta = with lib; {
    description = "The GIMP image editor";
    homepage = "https://www.gimp.org";
    maintainers = [ maintainers.griffithsjr ];
    platforms = platforms.darwin;
  };
}
