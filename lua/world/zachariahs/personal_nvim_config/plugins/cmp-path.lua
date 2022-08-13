return {
  spec = {
    'https://github.com/hrsh7th/cmp-path',
    after = { 'world.zachariahs.personal_nvim_config.plugins.cmp' },
  },
  cmp_source = {
    name = 'path',
    option = {
      trailing_slash = false,
      get_cwd = function()
        return vim.fn.getcwd()
      end,
    },
  }
}
