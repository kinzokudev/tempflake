{
  config.vim.projects.project-nvim = {
    enable = true;
    setupOpts = {
      patterns = [
        ".git"
        "_darcs"
        ".hg"
        ".bzr"
        ".svn"
        "Makefile"
        "package.json"
        ".solution"
        ".solution.toml"
      ];
      exclude_dirs = [ "~/" ];
      silent_chdir = true;
      manual_mode = false;
      exclude_chdir = {
        filetype = [
          ""
          "OverseerList"
          "alpha"
        ];
        buftype = [
          "nofile"
          "terminal"
        ];
      };
    };
  };
}
