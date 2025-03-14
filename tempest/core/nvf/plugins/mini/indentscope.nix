{ lib, ... }:
{
  config.vim = {
    mini.indentscope = {
      enable = true;
      setupOpts = {
        draw = {
          delay = 0;
          animation = lib.generators.mkLuaInline ''require('mini.indentscope').gen_animation.none()'';
        };
        options = {
          border = "top";
          try_as_border = true;
        };
        symbol = "▏";
      };
    };
    luaConfigRC.indentscope =
      # lua
      ''
        vim.api.nvim_create_autocmd({ "FileType" }, {
          desc = "Disable indentscope for certain filetypes",
          callback = function()
            local ignored_filetypes = {
              "aerial",
              "dashboard",
              "help",
              "lazy",
              "leetcode.nvim",
              "mason",
              "neo-tree",
              "NvimTree",
              "neogitstatus",
              "notify",
              "startify",
              "toggleterm",
              "Trouble",
              "calltree",
              "coverage"
            }
            if vim.tbl_contains(ignored_filetypes, vim.bo.filetype) then
              vim.b.miniindentscope_disable = true
            end
          end,
        })
      '';
  };
}
