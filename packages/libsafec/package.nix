{
  pkgs ? import <nixpkgs> { },
}:

pkgs.stdenv.mkDerivation (finalAttrs: {
  pname = "safeclib";
  version = "3.3.0";

  src = pkgs.fetchFromGitHub {
    owner = "rurban";
    repo = "safeclib";
    rev = "refs/tags/v${finalAttrs.version}";
    hash = "sha256-vwMyxGgJvvv2Nlo14HKZtq8YnmAVqAHDvBL6CUmbaYQ=";
  };

  patches = [
    # Fix linking error.
    # Upstreamed in v3.4.0, but intel-opeapi-vtune wants libsafec-3.3.so.3.
    (pkgs.fetchpatch {
      name = "0001-add-pic_flag-to-RETPOLINE-cflags-and-ldflags.patch";
      url = "https://github.com/rurban/safeclib/commit/23ae79fe84a3fa5d995b8c6b9be70587e37a6cd8.patch";
      hash = "sha256-iv9OZJT9WILug1vVmUgIh8RxGAx8accwR1R0LOxYqYQ=";
    })
  ];

  nativeBuildInputs = [ pkgs.autoreconfHook ];

  buildInputs = [ pkgs.perl ];

  env = {
    CFLAGS = "-Wno-error=dangling-pointer";
  };

  meta = {
    description = "Libc extension with all C11 Annex K functions";
    homepage = "https://github.com/rurban/safeclib";
    license = pkgs.lib.licenses.mit;
    maintainers = [ pkgs.lib.maintainers.xzfc ];
    platforms = pkgs.lib.platforms.all;
  };
})