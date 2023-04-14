return {
  spec = {
    'https://github.com/neovim/nvim-lspconfig',
    after = {'world.zachariahs.personal_nvim_config.plugins.cmp-lsp'},
    config = function()
      -- Setup formatting on save.
      vim.cmd([[
        augroup world-zachariahs-nvim_plugins-lspconfig-format_on_save
          autocmd!
          autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 1000)
        augroup end
      ]])


      -- Setup lspconfig.
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lsp = require('lspconfig')

      lsp.clangd.setup {
        capabilities = capabilities
      }
      lsp.tsserver.setup{
        capabilities = capabilities
      }
    end
  }
}
