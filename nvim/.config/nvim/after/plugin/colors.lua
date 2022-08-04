vim.g.catppuccin_flavour = 'mocha'

require('catppuccin').setup({
    color_overrides = {
        all = {
            base = '#1C1E21',
            mantle = '#161A23',
        },
        latte = {},
        frappe = {},
        macchiato = {},
        mocha = {},
    }
})

vim.cmd 'colorscheme catppuccin'
