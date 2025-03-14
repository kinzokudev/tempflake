{ lib, ... }:
{
  config.vim.notify.nvim-notify = {
    enable = true;
    setupOpts = {
      timeout = 2500;
      fps = 165;
      max_height = lib.generators.mkLuaInline ''function() return math.floor(vim.o.lines * 0.75) end'';
      max_width = lib.generators.mkLuaInline ''function() return math.floor(vim.o.columns * 0.75) end'';
    };
  };
}
