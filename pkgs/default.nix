{
  pkgs,
  inputs,
  lib,
  ...
}:
let
  inherit (pkgs) callPackage;
in
{
  test-thingy-01 = callPackage ./test-thingy-01 { };
}
