{
  config.vim.ui.noice = {
    enable = true;
    setupOpts = {
      presets = {
        bottom_search = true;
      };
      cmdline = {
        view = "cmdline";
        format = {
          cmdline = {
            conceal = false;
          };
          search_down = {
            conceal = false;
          };
          search_up = {
            conceal = false;
          };
          filter = {
            conceal = false;
          };
          lua = {
            conceal = false;
          };
          help = {
            conceal = false;
          };
          input = {
            conceal = false;
          };
        };
      };
      messages.enabled = false;
      lsp = {
        hover.enabled = false;
        progress.enabled = false;
        smart_move.enabled = false;
        message.enabled = false;
        signature.enabled = false;
      };
      format = {
        filter = {
          pattern = [
            ":%s*%%s*s:%s*"
            ":%s*%%s*s!%s*"
            ":%s*%%s*s/%s*"
            "%s*s:%s*"
            ":%s*s!%s*"
            ":%s*s/%s*"
          ];
          icon = "";
          lang = "regex";
        };
        replace = {
          pattern = [
            ":%s*%%s*s:%w*:%s*"
            ":%s*%%s*s!%w*!%s*"
            ":%s*%%s*s/%w*/%s*"
            "%s*s:%w*:%s*"
            ":%s*s!%w*!%s*"
            ":%s*s/%w*/%s*"
          ];
          icon = "󱞪";
          lang = "regex";
        };
      };
    };
  };
}
