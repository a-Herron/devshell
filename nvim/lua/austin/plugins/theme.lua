return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                no_italic = true,
                no_bold = true,
                integrations = {
                    cmp = true,
                    blink_cmp = true,
                    harpoon = true,
                    gitsigns = true,
                    dap = true,
                    dap_ui = true,
                    native_lsp = {
                        enabled = true,
                        virtual_text = {
                            errors = { "italic" },
                            hints = { "italic" },
                            warnings = { "italic" },
                            information = { "italic" },
                            ok = { "italic" },
                        },
                        underlines = {
                            errors = { "underline" },
                            hints = { "underline" },
                            warnings = { "underline" },
                            information = { "underline" },
                            ok = { "underline" },
                        },
                        inlay_hints = {
                            background = true,
                        },
                    },
                    snacks = {
                        enabled = true,
                    },
                    treesitter = true,
                },
            })
            vim.cmd.colorscheme "catppuccin"
        end
    },
    {
        "nvim-tree/nvim-web-devicons", 
        lazy = true
    }
}
