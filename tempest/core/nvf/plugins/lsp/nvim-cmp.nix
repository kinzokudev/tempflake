{ lib, ... }:
{
  config.vim.autocomplete.nvim-cmp = {
    enable = true;
    setupOpts = {
      snippet = {
        expand = lib.generators.mkLuaInline ''function(args) luasnip.lsp_expand(args.body) end'';
      };
      duplicates = {
        nvim_lsp = 1;
        lazydev = 1;
        luasnip = 1;
        cmp_tabnine = 1;
        buffer = 1;
        path = 1;
      };
      preselect = lib.generators.mkLuaInline ''cmp.PreselectMode.None'';
      completion.completeopt = "menu,menuone,noselect";
      confirm_opts = {
        behavior = lib.generators.mkLuaInline ''cmp.ConfirmBehavior.Replace'';
        select = false;
      };
      window = {
        completion = lib.generators.mkLuaInline ''cmp.config.window.bordered()'';
        documentation = lib.generators.mkLuaInline ''cmp.config.window.bordered()'';
      };
      mapping =
        lib.generators.mkLuaInline # lua

          ''
            {
              ["<PageUp>"] = cmp.mapping.select_prev_item {
                behavior = cmp.SelectBehavior.Select,
                count = 8,
              },
              ["<PageDown>"] = cmp.mapping.select_next_item {
                behavior = cmp.SelectBehavior.Select,
                count = 8,
              },
              ["<C-PageUp>"] = cmp.mapping.select_prev_item {
                behavior = cmp.SelectBehavior.Select,
                count = 16,
              },
              ["<C-PageDown>"] = cmp.mapping.select_next_item {
                behavior = cmp.SelectBehavior.Select,
                count = 16,
              },
              ["<S-PageUp>"] = cmp.mapping.select_prev_item {
                behavior = cmp.SelectBehavior.Select,
                count = 16,
              },
              ["<S-PageDown>"] = cmp.mapping.select_next_item {
                behavior = cmp.SelectBehavior.Select,
                count = 16,
              },
              ["<Up>"] = cmp.mapping.select_prev_item {
                behavior = cmp.SelectBehavior.Select,
              },
              ["<Down>"] = cmp.mapping.select_next_item {
                behavior = cmp.SelectBehavior.Select,
              },
              ["<C-p>"] = cmp.mapping.select_prev_item {
                behavior = cmp.SelectBehavior.Insert,
              },
              ["<C-n>"] = cmp.mapping.select_next_item {
                behavior = cmp.SelectBehavior.Insert,
              },
              ["<C-k>"] = cmp.mapping.select_prev_item {
                behavior = cmp.SelectBehavior.Insert,
              },
              ["<C-j>"] = cmp.mapping.select_next_item {
                behavior = cmp.SelectBehavior.Insert,
              },
              ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
              ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
              ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
              ["<C-y>"] = cmp.config.disable,
              ["<C-e>"] = cmp.mapping {
                i = cmp.mapping.abort(),
                c = cmp.mapping.close(),
              },
              ["<CR>"] = cmp.mapping.confirm { select = false },
              ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                  luasnip.expand_or_jump()
                else
                  fallback()
                end
              end, { "i", "s" }),
              ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                  luasnip.jump(-1)
                else
                  fallback()
                end
              end, { "i", "s" }),
            }
          '';
    };
  };
}
