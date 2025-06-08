local M = {}

local enabled = false

function M.toggle()
    enabled = not enabled
    vim.lsp.inlay_hint.enable(enabled)
end

return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        inlay_hints = { enabled = true },
    },
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


        vim.lsp.config('yamlls', {})
        vim.lsp.enable('yamlls')

        vim.lsp.config('vue_ls', {
            -- add filetypes for typescript, javascript and vue
            filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
            init_options = {
              vue = {
                -- disable hybrid mode
                hybridMode = false,
              },
            },
        })
        vim.lsp.enable('vue_ls')

        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
        vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, {desc = "Line Diagnostics"})
        vim.keymap.set("n", "K", vim.lsp.buf.hover,{ desc = "Hover"})
        vim.keymap.set("n", "<leader>cs", vim.lsp.buf.signature_help, {desc = "Signature help"})
        vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, {desc = "Signature help"})

    end,
    keys = {
        {
            "<leader>uh",
            function()
                M.toggle()
            end,
            desc = "Toggle inlay hints"
        }
    }
}
