{ lib, ... }:
{
  config.vim = {
    binds.whichKey = {
      enable = true;
      register = lib.mkForce {
        "<leader>b" = "󰓩 Buffers";
        "<leader>bs" = "󰒺 Sort Buffers";
        "<leader>f" = " Find";
        "<leader>l" = " LSP";
        "<leader>g" = "󰊢 Git";
        "<leader>u" = " UI";
        "<leader>t" = " Terminal";
        "<leader>d" = " Debugger";
      };
      setupOpts = {
        preset = "classic";
        win.border = "none";
        icons = {
          separator = "";
          rules = false;
          group = "";
        };
      };
    };
  };
}
