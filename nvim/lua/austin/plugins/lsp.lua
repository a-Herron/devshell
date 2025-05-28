return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()

        vim.lsp.config('gopls', {
            settings = {
                gopls = {
                    hints = {
                        assignVariableTypes = true,
                        compositeLiteralFields = true,
                        compositeLiteralTypes = true,
                        constantValues = true,
                        functionTypeParameters = true,
                        parameterNames = true,
                        rangeVariableTypes = true,
                    }
                }
            }
        })

        vim.lsp.enable('gopls')

        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)

    end
}
