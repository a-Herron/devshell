return {
    'saghen/blink.cmp',
     dependencies = { 'rafamadriz/friendly-snippets' },
     version = '1.*',
     opts = {
         keymap = { 
             preset = 'default',

            ["<C-h>"] = {function(cmp) cmp.show() end},
            ["<Tab>"] = { 'select_and_accept', 'fallback' },
         },
         completion = {
             documentation = { auto_show = true },
             ghost_text = { enabled = false}
         },
         sources = {
             default = { 'lsp', 'path', 'snippets', 'buffer' },
         },
         fuzzy = { implementation = "prefer_rust_with_warning" },
         --snippets = { preset = 'default' | 'luasnip' | 'mini_snippets' },
          -- Experimental signature help support
         signature = { enabled = true }
     },
     opts_extend = { "sources.default" }
}
