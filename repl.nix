# better repl with preloaded functions and libs already loaded
# https://bmcgee.ie/posts/2023/01/nix-and-its-slow-feedback-loop/#how-you-should-use-the-repl
{
  # host is passed down from the nrepl via a --arg argument, defaulting to the current host
  host ? "TEMPEST",
  ...
}:
let
  flake = builtins.getFlake (toString ./.);
  user = flake.userinfo.name;
in
rec {
  inherit (flake) inputs lib self;
  inherit (flake.inputs) nixpkgs;
  inherit flake host user;

  c = flake.nixosConfigurations.${host}.config;
  inherit (flake.nixosConfigurations.${host}) config;
  # o = c.custom;
  # inherit (c) hm;
  # hmo = hm.custom;
  inherit (flake.nixosConfigurations.${host}) pkgs;
}
