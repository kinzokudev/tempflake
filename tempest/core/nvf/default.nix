{ inputs, ... }:
{
  imports = [
    ./plugins
    ./config.nix
    ./keymaps.nix
    inputs.nvf.nixosModules.default
  ];
}
