return {
  spec = {
    'https://github.com/windwp/nvim-autopairs',
    after = {
      'world.zachariahs.nvim-plugins.cmp',
      'world.zachariahs.nvim-plugins.treesitter',
    },
    config = function()
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      local Rule = require('nvim-autopairs.rule')
      local npairs = require('nvim-autopairs')
      local conds = require('nvim-autopairs.conds')
      local ts_conds = require('nvim-autopairs.ts-conds')

      npairs.setup {
        disable_filetype = { "TelescopePrompt" },
        -- disable when recording or executing a macro
        disable_in_macro = false,
        -- disable when insert after visual block mode
        disable_in_visualblock = false,
        ignored_next_char = [=[[%w%%%'%[%"%.]]=],
        enable_moveright = true,
        -- add bracket pairs after quote
        enable_afterquote = true,
        -- check bracket in same line
        enable_check_bracket_line = true,
        enable_bracket_in_quote = true,
        -- switch for basic rule break undo sequence
        break_undo = true,
        check_ts = true,
        ts_config = {
            -- it will not add a pair on that treesitter node
            lua = {'string'},
            javascript = {'template_string'},
            -- don't check treesitter on java
            java = false,
        },
        map_cr = true,
        -- map the <BS> key
        map_bs = true,
        -- Map the <C-h> key to delete a pair
        map_c_h = false,
        -- map <c-w> to delete a pair if possible
        map_c_w = false, 
        fast_wrap = {
          map = '<M-e>',
          chars = { '{', '[', '(', '"', "'" },
          pattern = [=[[%'%"%)%>%]%)%}%,]]=],
          end_key = '$',
          keys = 'qwertyuiopzxcvbnmasdfghjkl',
          check_comma = true,
          highlight = 'Search',
          highlight_grey='Comment'
        },
      }

      npairs.add_rules({
        Rule("$", "$",{"tex", "latex"})
          -- don't add a pair if the next character is %
          :with_pair(conds.not_after_regex("%%"))
          -- don't add a pair if  the previous character is xxx
          :with_pair(conds.not_before_regex("xxx", 3))
          -- don't move right when repeat character
          :with_move(conds.none())
          -- don't delete if the next character is xx
          :with_del(conds.not_after_regex("xx"))
          -- disable adding a newline when you press <cr>
          :with_cr(conds.none()),
        Rule("$$","$$","tex")
          :with_pair(function(opts)
            if opts.line=="aa $$" then
              -- don't add pair on that line
              return false
            end
          end),
        -- disable for .vim files, but it work for another filetypes
        -- Rule("a","a","-vim"),
        -- press u1234 => u1234number
        -- Rule("u%d%d%d%d$", "number", "lua")
        --   :use_regex(true),
        -- press x1234 => x12341234
        -- Rule("x%d%d%d%d$", "number", "lua")
        --   :use_regex(true)
        --   :replace_endpair(function(opts)
        --     return opts.prev_char:sub(#opts.prev_char - 3,#opts.prev_char)
        --   end),
        -- you can do anything with regex +special key
        -- example press tab to uppercase text:
        -- press b1234s<tab> => B1234S1234S
        -- Rule("b%d%d%d%d%w$", "", "vim")
        --   :use_regex(true,"<tab>")
        --   :replace_endpair(function(opts)
        --     return
        --       opts.prev_char:sub(#opts.prev_char - 4,#opts.prev_char)
        --       .."<esc>viwU"
        --   end),
        -- you can exclude filetypes
        -- Rule("$$","$$", "-lua")
        -- press % => %% only while inside a comment or string
        Rule("%", "%", "lua")
          :with_pair(ts_conds.is_ts_node({'string','comment'})),
        Rule("$", "$", "lua")
          :with_pair(ts_conds.is_not_ts_node({'function'}))
      })
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done({
          filetypes = {
            -- "*" is a alias to all filetypes
            ["*"] = {
              ["("] = {
                kind = {
                  cmp.lsp.CompletionItemKind.Function,
                  cmp.lsp.CompletionItemKind.Method,
                },
                handler = require('nvim-autopairs.completion.handlers')["*"]
              }
            },
            -- lua = {
            --   ["("] = {
            --     kind = {
            --       cmp.lsp.CompletionItemKind.Function,
            --       cmp.lsp.CompletionItemKind.Method
            --     },
            --     ---@param char string
            --     ---@param item item completion
            --     ---@param bufnr buffer number
            --     handler = function(char, item, bufnr)
            --       -- Your handler function. Inpect with print(vim.inspect{char, item, bufnr})
            --     end
            --   }
            -- },
            -- Disable for tex
            -- tex = false,
          }
        })
      )
    end
  },
}
