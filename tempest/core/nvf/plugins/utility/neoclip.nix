{
  config.vim = {
    extraPlugins.neoclip = {
      package = "nvim-neoclip-lua";
      setup = "require('neoclip').setup {}";
    };
    keymaps = [
      {
        key = "<leader>fy";
        mode = "n";
        silent = true;
        desc = "Find yank history";
        action =
          # lua
          ''function () require("telescope").extensions.neoclip.default() end'';
        lua = true;
      }
    ];
  };
}
