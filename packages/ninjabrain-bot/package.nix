{
  stdenv,
  fetchurl,
  lib,
  openjdk,
  libxkbcommon,
  makeWrapper,
  libX11,
  libXt,
}:

stdenv.mkDerivation rec {
  pname = "ninjabrain-bot";
  version = "1.5.1";

  src = fetchurl {
    url = "https://github.com/Ninjabrain1/Ninjabrain-Bot/releases/download/1.5.1/Ninjabrain-Bot-1.5.1.jar";
    sha256 = "sha256-Rxu9A2EiTr69fLBUImRv+RLC2LmosawIDyDPIaRcrdw=";
  };

  nativeBuildInputs = [
    makeWrapper
  ];

  buildInputs = [
    openjdk
  ];

  linkedLibraries = [
    libxkbcommon
    libX11
    libXt
  ];

  dontUnpack = true;
  
  installPhase = ''
    mkdir -p $out/share/java $out/bin
    cp ${src} $out/share/java/${pname}-${version}.jar

    makeWrapper ${openjdk}/bin/java $out/bin/ninjabrain-bot --prefix LD_LIBRARY_PATH ":" ${lib.makeLibraryPath linkedLibraries} --add-flags "-jar $out/share/java/${pname}-${version}.jar"
  '';


}