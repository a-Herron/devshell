return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = 'main',
    build = ':TSUpdate',
    config = function()
        require'nvim-treesitter'.install { 'go', 'javascript', 'typescript', 'vue', 'json', 'yaml', 'lua', 'c_sharp' }
        vim.api.nvim_create_autocmd('FileType', {
            pattern = { 'go', 'js', 'ts', 'lua', 'json', },
            callback = function() vim.treesitter.start() end,
        })
    end
}
