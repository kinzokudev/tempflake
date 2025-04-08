{
  inputs,
  pkgs,
  ...
}:
inputs.devenv.lib.mkShell {
  inherit inputs pkgs;

  modules = [
    (
      { pkgs, ... }:
      {
        packages = with pkgs; [
          age
          sops
          cachix
          deadnix
          statix
          nixd
          cargo-edit
          nixfmt-rfc-style
          mdformat
          shfmt
          treefmt
        ];

        dotenv.enable = true;

        languages.rust = {
          enable = true;
        };
      }
    )
  ];
}
