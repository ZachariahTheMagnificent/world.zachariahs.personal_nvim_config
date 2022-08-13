return {
  spec = {
    'https://github.com/Mofiqul/vscode.nvim',
    config = function()
      -- For dark theme (neovim's default).
      vim.o.background = 'dark'
      -- Enable transparent background.
      vim.g.vscode_transparent = 1
      -- Enable italic comment.
      vim.g.vscode_italic_comment = 1
      -- Disable nvim-tree background color.
      vim.g.vscode_disable_nvimtree_bg = true
      -- Sets the colorscheme.
      vim.cmd [[colorscheme vscode]]
    end,
  },
}
