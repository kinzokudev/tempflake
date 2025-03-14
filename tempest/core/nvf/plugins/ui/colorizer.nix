{
  config.vim = {
    ui.colorizer = {
      enable = true;
      setupOpts.user_default_options = {
        AARRGGBB = true;
        RGB = true;
        RRGGBB = true;
        RRGGBBAA = true;
        css = true;
        mode = "background";
        rgb_fn = true;
        # sass = true;
        tailwind = true;
      };
    };
    luaConfigRC.colorizer =
      #lua
      ''
        vim.api.nvim_create_autocmd({ 'BufEnter' }, {
          pattern = '*',
          callback = function () vim.cmd('ColorizerAttachToBuffer') end
        })
      '';
  };
}
