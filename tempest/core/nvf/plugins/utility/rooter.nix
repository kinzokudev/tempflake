{ pkgs, ... }:
{
  config.vim.extraPlugins.rooter = {
    package = pkgs.vimPlugins.vim-rooter;
  };
}
