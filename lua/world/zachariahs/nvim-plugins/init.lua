local current_file_name = debug.getinfo(1,'S').source:sub(2)
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

local packer_bootstrapped = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
  packer_bootstrapped = true
end
-- Automatically reloads plugins every time this file is changed.
vim.cmd(string.format([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost %s source %s | PackerSync
  augroup end
]], current_file_name, current_file_name))
local loaded_spec = function(name)
  local spec = require(name).spec
  spec.as = name

  return spec
end


require('packer').startup({
  function()
    -- Packer can manage itself.
    use 'https://github.com/wbthomason/packer.nvim'

    
    use {
      loaded_spec('world.zachariahs.nvim-plugins.autopairs'),
      loaded_spec('world.zachariahs.nvim-plugins.bufferline'),
      loaded_spec('world.zachariahs.nvim-plugins.cmp-buffer'),
      loaded_spec('world.zachariahs.nvim-plugins.cmp-cmdline'),
      loaded_spec('world.zachariahs.nvim-plugins.cmp-dictionary'),
      loaded_spec('world.zachariahs.nvim-plugins.cmp-lsp-document-symbol'),
      loaded_spec('world.zachariahs.nvim-plugins.cmp-lsp'),
      loaded_spec('world.zachariahs.nvim-plugins.cmp-path'),
      loaded_spec('world.zachariahs.nvim-plugins.cmp-treesitter'),
      loaded_spec('world.zachariahs.nvim-plugins.cmp'),
      loaded_spec('world.zachariahs.nvim-plugins.cmp_luasnip'),
      loaded_spec('world.zachariahs.nvim-plugins.dap'),
      loaded_spec('world.zachariahs.nvim-plugins.dap-virtual-text'),
      loaded_spec('world.zachariahs.nvim-plugins.friendly-snippets'),
      loaded_spec('world.zachariahs.nvim-plugins.gitsigns'),
      loaded_spec('world.zachariahs.nvim-plugins.lspconfig'),
      loaded_spec('world.zachariahs.nvim-plugins.LuaSnip'),
      loaded_spec('world.zachariahs.nvim-plugins.telescope-dap'),
      loaded_spec('world.zachariahs.nvim-plugins.telescope'),
      loaded_spec('world.zachariahs.nvim-plugins.toggleterm'),
      loaded_spec('world.zachariahs.nvim-plugins.tree'),
      loaded_spec('world.zachariahs.nvim-plugins.treesitter'),
      loaded_spec('world.zachariahs.nvim-plugins.vscode'),
    }
    if packer_bootstrapped then
      require('packer').sync()
    end
  end,
  config = {
    display = {
      open_fn = require('packer.util').float,
    }
  },
})
