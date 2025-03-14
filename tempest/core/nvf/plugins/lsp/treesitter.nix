{
  config.vim = {
    treesitter = {
      enable = true;
      autotagHtml = true;
    };
    # treesitter default fold sets foldenable to false
    pluginRC.treesitter-fold =
      # lua
      ''
        vim.o.foldmethod = "expr"
        vim.o.foldexpr = "nvim_treesitter#foldexpr()"
      '';
  };
}
