{ pkgs, ... }:
{
  config.vim.lazy.plugins = {
    "dropbar.nvim" = {
      package = pkgs.vimPlugins.dropbar-nvim;
      setupModule = "dropbar";
      setupOpts = { };
      lazy = true;
      event = [ "BufWinEnter" ];
    };
  };
}
