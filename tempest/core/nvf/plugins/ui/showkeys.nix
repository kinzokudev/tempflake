{ pkgs, ... }:
{
  config.vim.lazy.plugins = {
    "showkeys" = {
      package = pkgs.vimUtils.buildVimPlugin {
        pname = "showkeys";
        version = "2025-01-07";
        src = pkgs.fetchFromGitHub {
          owner = "nvzone";
          repo = "showkeys";
          rev = "891f95ef94ac80bc7690a0df09c6112b4b822cac";
          sha256 = "a4ZMn3dmLLjuh1V6ASIN6uWWB9XRtjnoqj+2L8AIZys=";
        };
      };
      setupModule = "showkeys";
      setupOpts = {
        timeout = 1;
        maxkeys = 5;
        show_count = true;
        excluded_modes = [ "i" ];
      };

      lazy = true;

      cmd = [ "ShowkeysToggle" ];

      event = [ "BufEnter" ];
    };
  };
}
