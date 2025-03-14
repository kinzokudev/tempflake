{
  config.vim = {
    visuals.highlight-undo = {
      enable = true;
      setupOpts = {
        duration = 150;
        hlgroup = "IncSearch";
      };
    };
    luaConfigRC.highlight-undo =
      #lua
      ''
        vim.api.nvim_create_autocmd("TextYankPost", {
          desc = "Highlight yanked text",
          pattern = "*",
          callback = function()
            (vim.hl or vim.highlight).on_yank()
          end,
        })
      '';
  };
}
