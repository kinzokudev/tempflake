{
  config.vim = {
    debugger.nvim-dap = {
      enable = true;
      mappings = {
        continue = null;
        goDown = null;
        goUp = null;
        hover = null;
        restart = null;
        runLast = null;
        runToCursor = null;
        stepBack = null;
        stepInto = null;
        stepOut = null;
        stepOver = null;
        terminate = null;
        toggleBreakpoint = null;
        toggleDapUI = null;
        toggleRepl = null;
      };
      ui = {
        enable = true;
      };
    };
    keymaps = [
      {
        key = "<F5>";
        mode = "n";
        silent = true;
        desc = "Debugger: Start";
        lua = true;
        action = ''function() require("dap").continue() end'';
      }
      {
        key = "<S-F5>";
        mode = "n";
        silent = true;
        desc = "Debugger: Stop";
        lua = true;
        action = ''function() require("dap").terminate() end'';
      }
      {
        key = "<C-F5>";
        mode = "n";
        silent = true;
        desc = "Debugger: Restart";
        lua = true;
        action = ''function() require("dap").restart_frame() end'';
      }
      {
        key = "<F9>";
        mode = "n";
        silent = true;
        desc = "Debugger: Toggle breakpoint";
        lua = true;
        action = ''function() require("dap").toggle_breakpoint() end'';
      }
      {
        key = "<S-F9>";
        mode = "n";
        silent = true;
        desc = "Debugger: Start";
        lua = true;
        action =
          # lua
          ''
            function()
              vim.ui.input({ prompt = "Condition: " }, function(condition)
                if condition then require("dap").set_breakpoint(condition) end
              end)
            end
          '';
      }
      {
        key = "<F10>";
        mode = "n";
        silent = true;
        desc = "Debugger: Step Over";
        lua = true;
        action = ''function() require("dap").step_over() end'';
      }
      {
        key = "<S-F10>";
        mode = "n";
        silent = true;
        desc = "Debugger: Step Back";
        lua = true;
        action = ''function() require("dap").step_back() end'';
      }
      {
        key = "<F11>";
        mode = "n";
        silent = true;
        desc = "Debugger: Step Into";
        lua = true;
        action = ''function() require("dap").step_into() end'';
      }
      {
        key = "<S-F11>";
        mode = "n";
        silent = true;
        desc = "Debugger: Step Out";
        lua = true;
        action = ''function() require("dap").step_out() end'';
      }
      {
        key = "<leader>db";
        mode = "n";
        silent = true;
        desc = "Breakpoint (F9)";
        lua = true;
        action = ''function() require("dap").toggle_breakpoint() end'';
      }
      {
        key = "<leader>dB";
        mode = "n";
        silent = true;
        desc = "Clear Breakpoints";
        lua = true;
        action = ''function() require("dap").clear_breakpoints() end'';
      }
      {
        key = "<leader>dc";
        mode = "n";
        silent = true;
        desc = "Start/Continue (F5)";
        lua = true;
        action = ''function() require("dap").continue() end'';
      }
      {
        key = "<leader>dC";
        mode = "n";
        silent = true;
        desc = "Clear Breakpoints";
        lua = true;
        action =
          #lua
          ''
            function()
              vim.ui.input({ prompt = "Condition: " }, function(condition)
                if condition then require("dap").set_breakpoint(condition) end
              end)
            end
          '';
      }
      {
        key = "<leader>do";
        mode = "n";
        silent = true;
        desc = "Step Over (F10)";
        lua = true;
        action = ''function() require("dap").step_over() end'';
      }
    ];
  };
}
