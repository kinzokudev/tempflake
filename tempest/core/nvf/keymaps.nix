{
  config.vim.keymaps = [
    {
      key = "j";
      mode = [
        "n"
        "v"
      ];
      silent = true;
      expr = true;
      desc = "Move cursor down";
      action = "v:count == 0 ? 'gj' : 'j'";
    }
    {
      key = "k";
      mode = [
        "n"
        "v"
      ];
      silent = true;
      expr = true;
      desc = "Move cursor up";
      action = "v:count == 0 ? 'gk' : 'k'";
    }
    {
      key = "|";
      mode = "n";
      silent = true;
      desc = "Vertical Split";
      action = ":vsplit<CR>";
    }
    {
      key = "<leader>ww";
      mode = "n";
      silent = true;
      desc = "Other window";
      action = "<C-W>p";
    }
    {
      key = "<leader>wd";
      mode = "n";
      silent = true;
      desc = "Delete window";
      action = "<C-W>c";
    }
    {
      key = "\\";
      mode = "n";
      silent = true;
      desc = "Horizontal Split";
      action = ":split<CR>";
    }
    {
      key = "<C-BS>";
      mode = "i";
      silent = true;
      desc = "Enable CTRL+backspace to delete";
      action = "<C-W>";
    }
    {
      key = "0";
      mode = "n";
      silent = true;
      desc = "Go to the first character of the line (aliases 0 to ^)";
      action = "^";
    }
    {
      key = "c";
      mode = [
        "n"
        "x"
      ];
      silent = true;
      desc = "Change without yanking";
      action = "\"_c";
    }
    {
      key = "C";
      mode = [
        "n"
        "x"
      ];
      silent = true;
      desc = "Change without yanking";
      action = "\"_C";
    }
    {
      key = "x";
      mode = "n";
      silent = true;
      lua = true;
      desc = "Delte character without yanking it";
      action =
        #lua
        ''
          function()
            if vim.fn.col "." == 1 then
              local line = vim.fn.getline "."
              if line:match "^%s*$" then
                vim.api.nvim_feedkeys('"_dd', "n", false)
                vim.api.nvim_feedkeys("$", "n", false)
              else
                vim.api.nvim_feedkeys('"_x', "n", false)
              end
            else
              vim.api.nvim_feedkeys('"_x', "n", false)
            end
          end
        '';
    }
    {
      key = "x";
      mode = "x";
      silent = true;
      desc = "Delte all characters in line";
      action = "\"_x";
    }
    {
      key = "X";
      mode = "n";
      silent = true;
      lua = true;
      desc = "Delte character without yanking it";
      action =
        #lua
        ''
          function()
            if vim.fn.col "." == 1 then
              local line = vim.fn.getline "."
              if line:match "^%s*$" then
                vim.api.nvim_feedkeys('"_dd', "n", false)
                vim.api.nvim_feedkeys("$", "n", false)
              else
                vim.api.nvim_feedkeys('"_X', "n", false)
              end
            else
              vim.api.nvim_feedkeys('"_X', "n", false)
            end
          end
        '';
    }
    {
      key = "X";
      mode = "x";
      silent = true;
      desc = "Delte all characters in line";
      action = "\"_X";
    }
    {
      key = "p";
      mode = "x";
      silent = true;
      desc = "Paste content you've previously yanked";
      action = "P";
    }
    {
      key = "P";
      mode = "x";
      silent = true;
      desc = "Yank what you are going to override, then paste";
      action = "p";
    }
    {
      key = "<ESC>";
      mode = "n";
      silent = true;
      action =
        #lua
        ''
          function()
            if vim.fn.hlexists("Search") then
              vim.cmd("nohlsearch")
            else
              vim.api.nvim_feedkeys(
                vim.api.nvim_replace_termcodes("<ESC>", true, true, true),
                "n",
                true
              )
            end
          end
        '';
    }
    {
      key = "<S-Tab>";
      mode = "x";
      silent = true;
      desc = "Unindent line";
      action = "<gv";
    }
    {
      key = "<Tab>";
      mode = "x";
      silent = true;
      desc = "Indent line";
      action = ">gv";
    }
    {
      key = "<";
      mode = "x";
      silent = true;
      desc = "Unindent line";
      action = "<gv";
    }
    {
      key = ">";
      mode = "x";
      silent = true;
      desc = "Indent line";
      action = ">gv";
    }
    {
      key = "gg";
      mode = [
        "n"
        "x"
      ];
      silent = true;
      lua = true;
      desc = "gg and go to the first position";
      action =
        #lua
        ''
          function()
            vim.g.minianimate_disable = true
            if vim.v.count > 0 then
              vim.cmd("normal! " .. vim.v.count .. "gg")
            else
              vim.cmd("normal! gg0")
            end
            vim.g.minianimate_disable = false
          end
        '';
    }
    {
      key = "G";
      mode = [
        "n"
        "x"
      ];
      silent = true;
      lua = true;
      desc = "G and go to the first position";
      action =
        #lua
        ''
          function()
            vim.g.minianimate_disable = true
            vim.cmd("normal! G$")
            vim.g.minianimate_disable = false
          end
        '';
    }
    {
      key = "]t";
      mode = "n";
      silent = true;
      desc = "Next tab";
      action = ":tabnext<CR>";
    }
    {
      key = "[t";
      mode = "n";
      silent = true;
      desc = "Previous tab";
      action = ":tabprevious<CR>";
    }
    {
      key = "}t";
      mode = "n";
      silent = true;
      desc = "Last tab";
      action = ":tablast<CR>";
    }
    {
      key = "{t";
      mode = "n";
      silent = true;
      desc = "First tab";
      action = ":tabfirst<CR>";
    }
  ];
}
