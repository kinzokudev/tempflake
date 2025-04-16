{ pkgs, ... }:
{
  config.vim = {
    lazy.plugins = {
      "smart-splits.nvim" = {
        package = pkgs.vimPlugins.smart-splits-nvim;
        setupModule = "smart-splits";
        setupOpts = {
          ignored_filetypes = [
            "nofile"
            "quickfix"
            "qf"
            "prompt"
          ];
          ignored_buftypes = [ "nofile" ];
        };
        lazy = true;
      };
    };
    keymaps = [
      {
        key = "<C-h>";
        mode = "n";
        silent = true;
        action =
          # lua
          ''function () require('smart-splits').move_cursor_left({ at_edge = 'wrap' }) end'';
        lua = true;
      }
      {
        key = "<C-j>";
        mode = "n";
        silent = true;
        action =
          # lua
          ''function () require('smart-splits').move_cursor_down({ at_edge = 'wrap' }) end'';
        lua = true;
      }
      {
        key = "<C-k>";
        mode = "n";
        silent = true;
        action =
          # lua
          ''function () require('smart-splits').move_cursor_up({ at_edge = 'wrap' }) end'';
        lua = true;
      }
      {
        key = "<C-l>";
        mode = "n";
        silent = true;
        action =
          # lua
          ''function () require('smart-splits').move_cursor_right({ at_edge = 'wrap' }) end'';
        lua = true;
      }
      {
        key = "<C-Up>";
        mode = "n";
        silent = true;
        action =
          # lua
          ''function () require('smart-splits').resize_up() end'';
        lua = true;
      }
      {
        key = "<C-Down>";
        mode = "n";
        silent = true;
        action =
          # lua
          ''function () require('smart-splits').resize_down() end'';
        lua = true;
      }
      {
        key = "<C-Left>";
        mode = "n";
        silent = true;
        action =
          # lua
          ''function () require('smart-splits').resize_left() end'';
        lua = true;
      }
      {
        key = "<C-Right>";
        mode = "n";
        silent = true;
        action =
          # lua
          ''function () require('smart-splits').resize_right() end'';
        lua = true;
      }
    ];
  };
}
