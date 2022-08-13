return {
  spec = {
    'https://github.com/hrsh7th/cmp-buffer',
    after = { 'world.zachariahs.personal_nvim_config.plugins.cmp' },
  },
  cmp_source = {
    name = 'buffer',
    keyword_length = 3,
    option = {
      keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%([\-.]\w*\)*\)]],
      -- keyword_pattern = [[\k\+]]
      get_bufnrs = function()
        -- Source just from current buffer
        -- return { vim.api.nvim_get_current_buf() }
        -- Source from all buffers
        return vim.api.nvim_list_bufs()
      end,
      indexing_interval = 100,
      indexing_batch_size = 1000,
      max_indexed_line_length = 1024 * 40,
    },
  },
  cmp_comparators = function(...)
    return require('cmp_buffer'):compare_locality(...)
  end,
  
}
