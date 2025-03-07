{
  lib,
  stdenvNoCC,
  name ? "test-thingy-01",
  ...
}:
stdenvNoCC.mkDerivation {
  inherit name;
  version = "1.0";

  src = ./.;

  postInstall = # sh
    ''
      install -D ./test-01.sh $out/bin/test-thingy
    '';

  meta = {
    description = "test thingy";
    license = lib.licenses.gpl3;
    maintainers = [ lib.maintainers.kinzoku ];
    platforms = lib.platforms.linux;
  };
}
