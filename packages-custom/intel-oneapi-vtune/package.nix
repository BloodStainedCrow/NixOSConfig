{
  alsa-lib,
  atk,
  autoPatchelfHook,
  cairo,
  cups,
  dbus,
  elfutils,
  expat,
  fetchurl,
  file-rename,
  glib,
  gtk3,
  kmod,
  lib,
  libdrm,
  libndctl,
  libsafec,
  libxcrypt-legacy,
  libxkbcommon,
  mesa,
  ncurses5,
  nspr,
  nss,
  opencl-clang,
  p7zip,
  pango,
  stdenv,
  systemd,
  wrapGAppsHook3,
  readline,
  libx11,
  libxcomposite,
  libxdamage,
  libxext,
  libxfixes,
  libxrandr,
  libxcb,
}:

stdenv.mkDerivation (
  finalAttrs:
  let
    versionMajorMinor = lib.versions.majorMinor finalAttrs.version;
  in
  {
    pname = "intel-oneapi-vtune";
    version = "2026.1.0";

    src = fetchurl {
      url = "https://installer.repos.intel.com/oneapi/vtune/lin/intel.oneapi.lin.vtune,v=2026.1.0%2B13/cupPayload.cup";
      sha256 = "sha256-XFW6bKomTQlwspHL1uE0Mbr8d5xw4UIrsTMOHsWbZqg=";
    };

    nativeBuildInputs = [
      autoPatchelfHook
      file-rename
      p7zip
    ];

    buildInputs = [
      alsa-lib
      atk
      cairo
      cups
      dbus
      elfutils
      expat
      glib
      gtk3
      kmod
      libdrm
      libndctl
      libsafec
      libxcrypt-legacy
      libxkbcommon
      mesa
      ncurses5
      nspr
      nss
      opencl-clang
      pango
      stdenv.cc.cc.lib
      libx11
      libxcomposite
      libxdamage
      libxext
      libxfixes
      libxrandr
      libxcb
      readline
    ];

    unpackPhase = ''
      runHook preUnpack

      7za x $src

      # Fix percent-encoded filenames, e.g. "libstdc%2B%2B.so.6" -> "libstdc++.so.6"
      find -depth -name '*%*' -execdir rename 's/%2B/+/g; s/%5B/[/g; s/%5D/]/g' {} \;

      runHook postUnpack
    '';

    installPhase = ''
      runHook preInstall

      mkdir -p $out/opt/intel/oneapi
      mv _installdir/vtune $out/opt/intel/oneapi
      ln -s $out/opt/intel/oneapi/vtune/{${versionMajorMinor},latest}

      mkdir -p $out/bin
      for bin in vtune vtune-backend vtune-gui.bin; do
        ln -s $out/opt/intel/oneapi/vtune/${versionMajorMinor}/bin64/$bin $out/bin/
      done

      mkdir -p $out/share/applications
      cp $out/opt/intel/oneapi/vtune/${versionMajorMinor}/bin64/vtune-gui.desktop $out/share/applications/
      sed -i $out/share/applications/vtune-gui.desktop -e "
        s|^Exec=.*|Exec=vtune-gui|g;
        s|^Icon=./|Icon=$out/opt/intel/oneapi/vtune/${versionMajorMinor}/bin64/|g;
      "

      runHook postInstall
    '';



    autoPatchelfIgnoreMissingDeps = [
      "libffi.so.6" # Used in vendored python
      "libgdbm.so.4" # Used in vendored python
      "libgdbm_compat.so.4" # Used in vendored python
      "liboutputgenerator.so" # Used in gma/GTPin/Profilers/Examples/intel64/memorytrace.so
      "libsycl.so.9" # Used in bin64/self_check_apps/matrix.dpcpp/matrix.dpcpp

      "libopencl-clang.so.14"
    ];

    runtimeDependencies = [
      systemd # for zygote (vtune-gui)
    ];

    # meta = {
    #   changelog = "https://www.intel.com/content/www/us/en/developer/articles/release-notes/vtune-profiler-release-notes.html";
    #   description = "Performance analysis tool for x86-based machines";
    #   homepage = "https://www.intel.com/content/www/us/en/developer/tools/oneapi/vtune-profiler.html";
    #   license = lib.licenses.unfree;
    #   platforms = [ "x86_64-linux" ];
    # };
  }
)