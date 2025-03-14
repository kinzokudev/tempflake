{
  config.vim = {
    comments.comment-nvim = {
      enable = true;
    };
    keymaps = [
      {
        key = "<leader>/";
        mode = "n";
        silent = true;
        action =
          # lua
          ''
            function()
              require("Comment.api").toggle.linewise.count(
                vim.v.count > 0 and vim.v.count or 1
              )
            end
          '';
        desc = "Toggle comment";
        lua = true;
      }
      {
        key = "<leader>/";
        mode = "x";
        action = "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>";
        silent = true;
        desc = "Toggle comment";
      }
    ];
  };
}
