{
  inputs, ...
}:
{
  flake.modules.homeManager.factorio =
    {
      pkgs,
      lib,
      ...
    }:
    {
      home.packages = with pkgs; [
        (pkgs.factorio-space-age.overrideAttrs (oldAttrs: {
          # username = "BloodStainedCrow";
          # token = "";

          postFixup = (oldAttrs.postFixup or "") + ''
            wrapProgram $out/bin/factorio \
              --prefix LD_PRELOAD : ${pkgs.mimalloc}/lib/libmimalloc.so \
              --set MIMALLOC_ALLOW_LARGE_OS_PAGES 1 \
              --set MIMALLOC_PURGE_DELAY -1 \
              --set MIMALLOC_SHOW_STATS 1 \
              # --set MIMALLOC_RESERVE_HUGE_OS_PAGES 2 \
          '';
        }))
      ];
    };
}