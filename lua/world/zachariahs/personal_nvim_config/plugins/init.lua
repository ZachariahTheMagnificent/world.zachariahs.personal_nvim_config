local current_file_name = debug.getinfo(1,'S').source:sub(2)
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'


local function bootstrap_packer()
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.fn.packadd([[packer.nvim]])
    return true
  end

  return false
end


local packer_bootstrapped = bootstrap_packer()


-- Automatically reloads plugins every time this file is changed.
vim.cmd(string.format([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost %s source %s | PackerSync
  augroup end
]], current_file_name, current_file_name))


local function loaded_spec(name)
  local spec = require(name).spec
  spec.as = name

  return spec
end


require('packer').startup({
  function(use)
    -- Packer can manage itself.
    use('https://github.com/wbthomason/packer.nvim')


    use {
      loaded_spec('world.zachariahs.personal_nvim_config.plugins.autopairs'),
      loaded_spec('world.zachariahs.personal_nvim_config.plugins.bufferline'),
      loaded_spec('world.zachariahs.personal_nvim_config.plugins.cmp-buffer'),
      loaded_spec('world.zachariahs.personal_nvim_config.plugins.cmp-cmdline'),
      loaded_spec('world.zachariahs.personal_nvim_config.plugins.cmp-dictionary'),
      loaded_spec('world.zachariahs.personal_nvim_config.plugins.cmp-lsp-document-symbol'),
      loaded_spec('world.zachariahs.personal_nvim_config.plugins.cmp-lsp'),
      loaded_spec('world.zachariahs.personal_nvim_config.plugins.cmp-path'),
      loaded_spec('world.zachariahs.personal_nvim_config.plugins.cmp-treesitter'),
      loaded_spec('world.zachariahs.personal_nvim_config.plugins.cmp'),
      loaded_spec('world.zachariahs.personal_nvim_config.plugins.cmp_luasnip'),
      loaded_spec('world.zachariahs.personal_nvim_config.plugins.dap'),
      loaded_spec('world.zachariahs.personal_nvim_config.plugins.dap-virtual-text'),
      loaded_spec('world.zachariahs.personal_nvim_config.plugins.friendly-snippets'),
      loaded_spec('world.zachariahs.personal_nvim_config.plugins.gitsigns'),
      loaded_spec('world.zachariahs.personal_nvim_config.plugins.lspconfig'),
      loaded_spec('world.zachariahs.personal_nvim_config.plugins.LuaSnip'),
      loaded_spec('world.zachariahs.personal_nvim_config.plugins.telescope-dap'),
      loaded_spec('world.zachariahs.personal_nvim_config.plugins.telescope'),
      loaded_spec('world.zachariahs.personal_nvim_config.plugins.toggleterm'),
      loaded_spec('world.zachariahs.personal_nvim_config.plugins.tree'),
      loaded_spec('world.zachariahs.personal_nvim_config.plugins.treesitter'),
      loaded_spec('world.zachariahs.personal_nvim_config.plugins.vscode'),
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
