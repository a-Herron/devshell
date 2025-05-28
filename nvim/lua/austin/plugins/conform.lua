return {
    'stevearc/conform.nvim',
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
    config = function()
        local conform = require('conform')

        conform.setup({
            formatters_by_ft = {
                go = { "gofumpt" }
            },
            format_on_save = {
                lsp_fallback = true,
                async = false,
                timeout_ms = 2000
            }
        })
    end
}
