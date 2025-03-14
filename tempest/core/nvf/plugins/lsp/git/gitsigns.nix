{
  config.vim = {
    git.gitsigns = {
      enable = true;
      codeActions.enable = true;
      mappings = {
        blameLine = null;
        diffProject = null;
        diffThis = null;
        nextHunk = null;
        previewHunk = null;
        previousHunk = null;
        resetBuffer = null;
        resetHunk = null;
        stageBuffer = null;
        stageHunk = null;
        toggleBlame = null;
        toggleDeleted = null;
        undoStageHunk = null;
      };
    };
    keymaps = [
      {
        key = "]g";
        mode = "n";
        silent = true;
        lua = true;
        desc = "Next Git hunk";
        action = ''function() require("gitsigns").nav_hunk('next') end'';
      }
      {
        key = "[g";
        mode = "n";
        silent = true;
        lua = true;
        desc = "Previous Git hunk";
        action = ''function() require("gitsigns").nav_hunk('prev') end'';
      }
      {
        key = "<leader>gl";
        mode = "n";
        silent = true;
        lua = true;
        desc = "View Git blame";
        action = ''function() require("gitsigns").blame_line() end'';
      }
      {
        key = "<leader>gL";
        mode = "n";
        silent = true;
        lua = true;
        desc = "View full Git blame";
        action = ''function() require("gitsigns").blame_line({ full = true }) end'';
      }
      {
        key = "<leader>gp";
        mode = "n";
        silent = true;
        lua = true;
        desc = "Preview Git hunk";
        action = ''function() require("gitsigns").preview_hunk() end'';
      }
      {
        key = "<leader>gh";
        mode = "n";
        silent = true;
        lua = true;
        desc = "Reset Git hunk";
        action = ''function() require("gitsigns").reset_hunk() end'';
      }
      {
        key = "<leader>gr";
        mode = "n";
        silent = true;
        lua = true;
        desc = "Reset Git buffer";
        action = ''function() require("gitsigns").reset_buffer() end'';
      }
      {
        key = "<leader>gs";
        mode = "n";
        silent = true;
        lua = true;
        desc = "Stage Git hunk";
        action = ''function() require("gitsigns").stage_hunk() end'';
      }
      {
        key = "<leader>gS";
        mode = "n";
        silent = true;
        lua = true;
        desc = "Unstage Git hunk";
        action = ''function() require("gitsigns").undo_stage_hunk() end'';
      }
      {
        key = "<leader>gd";
        mode = "n";
        silent = true;
        lua = true;
        desc = "View Git diff";
        action = ''function() require("gitsigns").diffthis() end'';
      }
      {
        key = "<leader>gP";
        mode = "n";
        silent = true;
        lua = true;
        desc = "Open in GitHub";
        action = ''function() vim.cmd(":GBrowse") end'';
      }
    ];
  };
}
