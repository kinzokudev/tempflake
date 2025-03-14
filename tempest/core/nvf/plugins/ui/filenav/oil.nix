{ pkgs, ... }:
{
  config.vim = {
    extraPlugins = {
      oil = {
        package = pkgs.vimPlugins.oil-nvim;
        setup = "require('oil').setup()";
      };
    };
    maps.normal = {
      "<leader>o" = {
        silent = true;
        noremap = true;
        lua = true;
        desc = "Toggle oil (float)";
        action =
          # lua
          ''
            function()
              require('oil').toggle_float()
            end
          '';
      };
      "<leader>O" = {
        silent = true;
        noremap = true;
        lua = false;
        desc = "Open oil (non-float)";
        action = ":Oil<CR>";
      };
    };
  };
}
