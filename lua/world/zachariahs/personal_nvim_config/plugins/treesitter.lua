return {
  spec = {
    'https://github.com/nvim-treesitter/nvim-treesitter',
    run = function()
      vim.cmd [[TSUpdate]]
    end,
  },
}
