{
  config.vim.binds.whichKey.register = {
    "<leader>g" = "󰊢 Git";
  };
  imports = [
    ./gitsigns.nix
    ./git-fugitive.nix
  ];
}
