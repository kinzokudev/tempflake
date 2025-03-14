{
  config.vim = {
    terminal.toggleterm = {
      enable = true;
      lazygit.enable = true;
      mappings.open = "<F7>";
      setupOpts = {
        winbar.enabled = false;
        start_in_insert = true;
        size = 10;
        shading_factor = 2;
        direction = "float";
        float_opts = {
          border = "rounded";
        };
      };
    };
    keymaps = [
      {
        key = "<leader>tt";
        mode = [ "n" ];
        action = ":ToggleTerm direction=float<cr>";
        silent = true;
        desc = "Toggleterm float";
      }
      {
        key = "<leader>th";
        mode = [ "n" ];
        action = ":ToggleTerm size=10 direction=horizontal<cr>";
        silent = true;
        desc = "Toggleterm horizontal split";
      }
      {
        key = "<leader>tv";
        mode = [ "n" ];
        action = ":ToggleTerm size=80 direction=vertical<cr>";
        silent = true;
        desc = "Toggleterm vertical split";
      }

      {
        key = "<C-h>";
        mode = [ "t" ];
        action = "<cmd>wincmd h<cr>";
        silent = true;
        desc = "Terminal left window navigation";
      }
      {
        key = "<C-j>";
        mode = [ "t" ];
        action = "<cmd>wincmd j<cr>";
        silent = true;
        desc = "Terminal down window navigation";
      }
      {
        key = "<C-k>";
        mode = [ "t" ];
        action = "<cmd>wincmd k<cr>";
        silent = true;
        desc = "Terminal up window navigation";
      }
      {
        key = "<C-l>";
        mode = [ "t" ];
        action = "<cmd>wincmd l<cr>";
        silent = true;
        desc = "Terminal right window navigation";
      }
    ];
  };
}
