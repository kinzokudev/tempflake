{ lib, ... }:
{
  config.vim.mini.animate = {
    enable = true;
    setupOpts = {
      open.enable = false;
      resize.timing = lib.generators.mkLuaInline ''require("mini.animate").gen_timing.linear { duration = 33, unit = "total" }'';
      scroll = {
        timing = lib.generators.mkLuaInline ''require("mini.animate").gen_timing.linear { duration = 50, unit = "total" }'';
        subscroll =
          lib.generators.mkLuaInline # lua

            ''
              require("mini.animate").gen_subscroll.equal {
                predicate = function(total_scroll)
                  return total_scroll > 1
                end,
              }
            '';
      };
      cursor.enable = false;
    };
  };
}
