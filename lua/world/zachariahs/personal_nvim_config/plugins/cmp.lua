return {
  spec = {
    'https://github.com/hrsh7th/nvim-cmp',
    after = {'world.zachariahs.personal_nvim_config.plugins.LuaSnip'},
    config = function()
      local cmp = require'cmp'

      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          require('world.zachariahs.personal_nvim_config.plugins.cmp-lsp').cmp_source,
          require('world.zachariahs.personal_nvim_config.plugins.cmp_luasnip').cmp_source,
          require('world.zachariahs.personal_nvim_config.plugins.cmp-treesitter').cmp_source,
          require('world.zachariahs.personal_nvim_config.plugins.cmp-path').cmp_source,
          require('world.zachariahs.personal_nvim_config.plugins.cmp-buffer').cmp_source,
          require('world.zachariahs.personal_nvim_config.plugins.cmp-dictionary').cmp_source,
        }),
        sorting = { comparators = {
          require('world.zachariahs.personal_nvim_config.plugins.cmp-buffer').cmp_comparator,
        }}
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          require('world.zachariahs.personal_nvim_config.plugins.cmp-cmdline').cmp_source,
        })
      })

      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          require('world.zachariahs.personal_nvim_config.plugins.cmp-lsp-document-symbol').cmp_source,
          require('world.zachariahs.personal_nvim_config.plugins.cmp-buffer').cmp_source,
        })
      })

    end,
  }
}
