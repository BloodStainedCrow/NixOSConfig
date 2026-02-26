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
  xorg,
  readline,
}:

stdenv.mkDerivation (
  finalAttrs:
  let
    versionMajorMinor = lib.versions.majorMinor finalAttrs.version;
  in
  {
    pname = "intel-oneapi-vtune";
    version = "2025.9.0";

    src = fetchurl {
      url = "https://installer.repos.intel.com/oneapi/vtune/lin/intel.oneapi.lin.vtune,v=2025.9.0%2B10/cupPayload.cup";
      sha256 = "sha256-G6+do6mXse3BS8k61Sx9tn61HmZcrS1zRQAfgJQdBoc=";
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
      xorg.libX11
      xorg.libXcomposite
      xorg.libXdamage
      xorg.libXext
      xorg.libXfixes
      xorg.libXrandr
      xorg.libxcb
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
      "libsycl.so.8" # Used in bin64/self_check_apps/matrix.dpcpp/matrix.dpcpp

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