{
  pkgs,
  ...
}:
{
  config.vim = {
    enableLuaLoader = true;
    extraPackages = with pkgs; [
      git
      fzf
      ripgrep
      fd
      zoxide
    ];
    luaConfigPost =
      # lua
      ''
        vim.api.nvim_create_autocmd("InsertEnter", {
          pattern = "*",
          command = "set number norelativenumber",
        })
        vim.api.nvim_create_autocmd("InsertLeave", {
          pattern = "*",
          command = "set number relativenumber",
        })
      '';
    viAlias = true;
    vimAlias = true;
    lineNumberMode = "relNumber";
    searchCase = "smart";
    preventJunkFiles = true;
    spellcheck = {
      enable = true;
      programmingWordlist.enable = true;
    };
    globals = {
      mapleader = " ";
      maplocalleader = ",";
      big_file = {
        size = 1024 * 5000;
        lines = 50000;
      };
      editorconfig = true;
    };
    useSystemClipboard = true;
    options = {
      breakindent = true;
      clipboard = "unnamedplus";
      cmdheight = 0;
      completeopt = "menu,menuone,noselect";
      copyindent = true;
      cursorline = true;
      cursorlineopt = "number";
      expandtab = true;
      fileencoding = "utf-8";
      foldenable = true;
      foldlevel = 99;
      foldlevelstart = 99;
      foldcolumn = "1";
      ignorecase = true;
      infercase = true;
      sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,winpos,terminal";

      laststatus = 3;
      linebreak = true;
      number = true;
      preserveindent = true;
      pumheight = 10;
      relativenumber = false;
      shiftwidth = 2;
      showmode = false;
      showtabline = 2;
      signcolumn = "yes";
      smartcase = true;
      smartindent = false;
      splitbelow = true;
      splitright = true;
      tabstop = 2;

      termguicolors = true;
      undofile = true;
      updatetime = 300;
      virtualedit = "block";
      writebackup = false;
      shada = "!,'1000,<50,s10,h";
      history = 1000;
      swapfile = false;
      wrap = true;
      colorcolumn = "80";
      mousescroll = "ver:1,hor:0";
      guicursor = "n:blinkon200,i-ci-ve:ver25";
      autochdir = true;
      scrolloff = 1000;
      sidescrolloff = 8;
      selection = "old";
    };
  };

}
