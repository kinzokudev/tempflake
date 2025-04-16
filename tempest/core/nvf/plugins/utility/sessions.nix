{ pkgs, ... }:
{
  config.vim.lazy.plugins = {
    "persistence.nvim" = {
      package = pkgs.vimPlugins.persistence-nvim;
      setupModule = "persistence";
      setupOpts = { };
      lazy = true;
      event = [ "BufReadPre" ];
    };
  };
}
