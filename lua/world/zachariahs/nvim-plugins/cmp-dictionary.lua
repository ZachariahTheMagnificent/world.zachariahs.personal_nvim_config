return {
  spec = {
    'https://github.com/uga-rosa/cmp-dictionary',
    after = { 'world.zachariahs.nvim-plugins.cmp' },
    config = function()
      require("cmp_dictionary").setup({
        dic = {
          ["*"] = { "/usr/share/dict/words" },
          -- ["lua"] = "path/to/lua.dic",
          -- ["javascript,typescript"] = { "path/to/js.dic", "path/to/js2.dic" },
          -- filename = {
          --   ["xmake.lua"] = { "path/to/xmake.dic", "path/to/lua.dic" },
          -- },
          -- filepath = {
          --   ["%.tmux.*%.conf"] = "path/to/tmux.dic"
          -- },
          spelllang = {
            en = { "/usr/share/dict/british-english" },
            en_gb = { "/usr/share/dict/british-english" },
            en_us = { "/usr/share/dict/american-english" },
          },
        },
        -- The following are default values.
        exact = 2,
        first_case_insensitive = false,
        document = true,
        document_command = "wn %s -over",
        async = true, 
        capacity = 5,
        debug = false,
      })
    end,
  },
  cmp_source = {
    name = "dictionary",
    keyword_length = 2,
  },
}
