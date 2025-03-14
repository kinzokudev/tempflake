{
  pkgs,
  ...
}:
{
  config.vim.lazy.plugins = with pkgs.vimPlugins; {
    "aerial.nvim" = {
      package = aerial-nvim;
      setupModule = "aerial";
      setupOpts = {
        open_automatic = false;
        nerd_font = true;
        autojump = true;
        link_folds_to_tree = true;
        link_tree_to_folds = true;
        attach_mode = "global";
        backends = [
          "lsp"
          "treesitter"
          "markdown"
          "man"
        ];
        filter_kind = false;
        layout = {
          max_width = 28;
          default_direction = "right";
          placement = "edge";
        };
        show_guides = true;
        guides = {
          mid_item = "├ ";
          last_item = "└ ";
          nested_top = "│ ";
          whitespace = "  ";
        };
      };
      lazy = true;
      event = [ "BufEnter" ];
    };
  };
}
