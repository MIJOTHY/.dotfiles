{ stdenv, lib, fetchurl, undmg }:

stdenv.mkDerivation rec {
  pname = "Slack";
  version = "4.8.0";

  buildInputs = [ undmg ];
  sourceRoot = ".";
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
      mkdir -p "$out/Applications"
      cp -r ${pname}.app "$out/Applications/${pname}.app"
    '';

  src = fetchurl {
    name = "${pname}-${version}.dmg";
    url = "https://downloads.slack-edge.com/releases/macos/${version}/prod/x64/Slack-${version}-macOS.dmg";
    sha256 = "428ec2b5a9d5eb3b408c1cafa3977daeff0391c7d71656773c6ce535d8e0424c";
  };

  meta = with lib; {
    description = "Slack, several people are typing";
    homepage = "https://slack.com/intl/en-gb/";
    maintainers = [ maintainers.griffithsjr ];
    platforms = platforms.darwin;
  };
}
