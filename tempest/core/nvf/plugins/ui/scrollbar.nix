{
  config.vim.visuals.nvim-scrollbar = {
    enable = true;
    setupOpts = {
      handlers = {
        gitsigns = true;
        ale = true;
        search = false;
      };
      excluded_filetypes = [
        "cmp_docs"
        "cmp_menu"
        "noice"
        "prompt"
        "TelescopePrompt"
        "alpha"
      ];
    };
  };
}
