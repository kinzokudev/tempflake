{
  config.vim.snippets.luasnip = {
    enable = true;
    setupOpts = {
      history = true;
      delete_check_events = "TextChanged";
      region_check_events = "CursorMoved";
    };
    providers = [ "friendly-snippets" ];
  };
}
