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

        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
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
