return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        scope = { enabled = true },
        explorer = { enabled = true },
        indent = { enabled = true },
        input = { enabled = true },
        picker = { 
            enabled = true,
            sources = {
                explorer = { auto_close = true },
            }
        },
        git = { enabled = true },
        statuscolumn = { enabled = true},
        words = { enabled = true },
        zen = { enabled = true },
    },
    keys = {
        {"<leader>e", function() Snacks.explorer() end, desc = "File explorer"},
        {"<leader>ff", function() Snacks.picker.files() end, desc = "Find Files"},
        {"<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files"},
        {"<leader>fb", function() Snacks.picker.buffers() end, desc = "Find Buffers"},


        {"<leader>sg", function() Snacks.picker.grep() end, desc = "Search grep"},
        {"<leader>sw", function() Snacks.picker.grep_word() end, desc = "Search words"},
        {"<leader>sk", function() Snacks.picker.keymaps() end, desc = "Search keymaps"},
        {"<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Search diagnostics"},
        {"<leader>sq", function() Snacks.picker.qflist() end, desc = "Search quickfix list"},
        {"<leader>su", function() Snacks.picker.undo() end, desc = "Undo history"},
        {"<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes"},

        {"gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition"},
        {"gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration"},
        {"gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References"},
        {"gi", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation"},
        {"gt", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto type definition"},

        {"<leader>z", function() Snacks.zen() end, desc = "Toggle Zen Mode"},
        {"<leader>t", function() Snacks.terminal() end, desc = "Toggle terminal"}
    }
}
